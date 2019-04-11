% Make a global mesh multiscale
clearvars; clc; close all
addpath(genpath('~/MATLAB/'));

%% STEP 1: set mesh extents and set parameters for mesh. 
%% The greater US East Coast and Gulf of Mexico region
min_el    = 90;                 % minimum resolution in meters.  
max_el_ns = min_el*5; 
max_el   = [25e3 0 -inf;
            max_el_ns inf 0]; 

grade     = 0.25;               % mesh grade in decimal percent. 
R         = -5; 			    % Number of elements to resolve feature.
bo        = 2.5;                % min underwater depth
elev      = 10;                 % max overland height
CFL       = 0.75;               % set target CFL
g         = 9.81;
U         = sqrt(g*max(bo,1)) + sqrt(g./max(bo,1));
dt        = round(CFL*min_el/U,0);  % set target dt

bathy    = '../BATHY/SRTM15+V2.nc';  % the bathy data
shp      = '../SRTM3/SWBD/';
hgt      = '../SRTM3/HGT/';    

outname   = 'SRTM3_';

lonmin    = 34;
lonmax    = 34;
latmin    = -21;
latmax    = -21;

jj = 0;
for ii = lonmin:lonmax
    for jj = latmin:latmax

        bbox = [ii ii+1; jj jj+1];
        
        lonstr = pad(num2str(abs(ii)),3,'left','0');
        if ii >= 0; londir = 'e'; else; londir = 'w'; end
        latstr = pad(num2str(abs(jj)),2,'left','0');
        if jj >= 0; latdir = 'n'; else; latdir = 's'; end
        
        % lmsl filename
        lmsl = [shp londir lonstr latdir latstr];
        listing = dir([lmsl '*']);
        [~,lmsl] = fileparts(listing(1).name);
        lmsl = [listing(1).folder '/' lmsl];
        
        % topo filenames
        topo = [hgt upper(latdir) latstr upper(londir) lonstr '.nc'];     
        
        %% Calculate ocean only portion 
        
        % Geodata
        gdat = geodata('dem',bathy,'shp',lmsl,'h0',min_el,'bbox',bbox);
        % delete mainland parts of shapefile near bbox edge
        outerbox = gdat.outer(1:find(isnan(gdat.outer(:,1)))-1,:);
        [~,dst] = ourKNNsearch(outerbox',gdat.mainland',1);
        gdat.mainland(dst < gdat.h0/111e3,:) = [];

        % Edgefx
        fh   = edgefx('geodata',gdat,'fs',R,'max_el',max_el,...
                      'max_el_ns',max_el_ns,'dt',dt,'g',grade); 

        % Mesh
        mshopts = meshgen('ef',fh,'bou',gdat,'dj_cutoff',1e-3,...
                          'plot_on',1,'proj','utm');
        mshopts = mshopts.build;
        mo      = mshopts.grd; % get out the msh object      
        mo      = interp(mo,gdat);  
        mo.b    = max(mo.b,bo);

        % Get the fixed edges
        [egfix,pfix] = extdom_edges2(mo.t,mo.p) ;
        egfix = renumberEdges(egfix) ;
        fixboxes(1) = 1;

        %% Get full ocean + land mesh with fixed edges
        % Geodata
        gdat = geodata('dem',bathy,'bbox',bbox,'h0',min_el,'fp',1);
        gdatl = geodata('dem',topo,'shp',lmsl,'bbox',bbox,'h0',min_el);
        % delete mainland parts of shapefile near bbox edge
        outerbox = gdatl.outer(1:find(isnan(gdatl.outer(:,1)))-1,:);
        [~,dst] = ourKNNsearch(outerbox',gdatl.mainland',1);
        gdatl.mainland(dst < gdatl.h0/111e3,:) = [];

        % Mesh
        mshopts = meshgen('ef',fh,'bou',gdat,'plot_on',1,'proj','utm',... 
                          'itmax',200,'pfix',pfix,...
                          'egfix',egfix,'fixboxes',fixboxes);
        mshopts = mshopts.build; 
        mlo     = mshopts.grd; % get out the msh object  

        %%% Merge the ocean and ocean+land together
        %m = MergeFP(mo,mlo); 
        
        %% Interp bathy and trim mesh
        % Interp bathy
        m = interpFP(mlo,gdatl,mo,bo) ;

        % Delete above 10 m flooplain
        m = pruneOverlandMesh(m,elev); 

        % Make sure 10 sec timestep possible
        m = CheckTimestep(m,dt,0.75);
        
        save([outname londir lonstr latdir latstr '.mat'],'m')
    end
end
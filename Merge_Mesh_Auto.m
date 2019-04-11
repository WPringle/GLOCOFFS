% Make a global mesh multiscale
clearvars; clc; close all
addpath(genpath('~/MATLAB/'));

dt = 10;

%% Identify boxes to use
% lonmin    = 34;
% lonmax    = 34;
% latmin    = -21;
% latmax    = -21;

boxes{1} = 'e034s20';
boxes{2} = 'e034s21';

%% Merge Meshes
outname    = ['GLOCOFFS_' datestr(today)];
globalfile = '../MESHES/Global_2km_SRTMv2+ICE_DT10s.mat';
localdir   = '../MESHES/SRTM3_';

mhigh = [];
for box = boxes
    load([localdir box{1}]); 
    if ~isempty(mhigh)
        mhigh = m + mhigh;
    else
        mhigh = m;
    end   
end

mhigh = CheckTimestep(mhigh,10,0.75);

load(globalfile);

m = mhigh + m; 

m = CheckTimestep(m,10,0.75);

save([outname '.mat'],'m')

%% Make f15 data using the following times, constituents and stations
TS = '2019-03-13 00:00'; % simulation start time
TE = '2019-03-19 12:00'; % simulation end time
% List of constituents for tidal potential and SAL terms (also for boundary
% conditions but SA and SSA will be omitted automatically)
CONST = {'M2','S2','N2','K2','K1','O1','Q1','P1','SA','SSA','MM','MF'};

NWS = 14; % Use grib2 reader
WTIMINC = 3600; %[s] hourly winds

% Make the fort.15 struct
m = Make_f15(m,TS,TE,dt,'NWS',NWS,'WTIMNC',WTIMINC) ; 
              %,'const',CONST); %,'

% enter in additional parameters manually
m.f15.slam = [0 0];
m.f15.runid  = 'Surge_wFV3-GFS';
m.f15.rundes = outname; % Run description
m.f15.nscreen = ceil(12*3600/m.f15.dtdp);
m.f15.dramp = 0.25;  % Ramping quarter day      
m.f15.nramp = 1;   
m.f15.extraline(9).msg = 'wpringle@nd.edu'; % type your email here
m.f15.extraline(4).msg = ['HR Boxes Used: ' strjoin(boxes)];
m.f15.extraline(6).msg = 'Comments: forced with hourly FV3-GFS, no tides';
m.f15.extraline(1).msg = m.f15.rundes; 
% station output type and interval
%out = 1; %
%m.f15.oute  = [5 0 m.f15.rndy ceil(out*3600/m.f15.dtdp)];
%m.f15.outv  = [5 0 m.f15.rndy ceil(out*3600/m.f15.dtdp)];
% global output type and interval
out = 1; %hour
m.f15.outge = [5 m.f15.dramp m.f15.rndy ceil(out*3600/m.f15.dtdp)];
m.f15.outgm = [5 m.f15.dramp m.f15.rndy ceil(out*3600/m.f15.dtdp)];

% Make f13 data
% Calculate primitive weighting
m = Calc_tau0( m );


% Calculate internal tide friction
% Please select which one to use
%N_filename = 'E:\Global_Data\WOA_Data\Gridded_N_values.mat'; % this is a .mat file with gridded 
%                  % values of decadal-averaged annual buoyancy frequencies 
%m = Calc_IT_Fric(m,N_filename,'cutoff_depth',250,'Cit',2.75);

% Make f24 SAL data
% Download all the pertinent FES2014 load SAL constituent information from:
% ftp://ftp.legos.obs-mip.fr/pub/FES2012-project/data/LSA/FES2014/
% Put this in the datasets directory for the following call to work (or you
% may specify another directory explicitly; see Make_f24 help)
%m = Make_f24( m );

write(m,outname)
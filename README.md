# Latest Forecast

## Global Results

### Hydrodynamic: Maximum Storm Tide (Surge + Astronomical Tide) Anomaly

Anomaly from Highest Astronomical Tide (HAT); estimated by the maximum water level from a 1-year (2018) tide-only simulation

NB: Only showing surge at the moment. Click to see closeup of regions

[NA](MaxStormTide_NA2km.png) ・ [WE](MaxStormTide_WE2km.png) ・ [EA](MaxStormTide_EA2km.png) ・ [SA](MaxStormTide_SA2km.png) ・ [WP](MaxStormTide_WP2km.png) ・ [OC](MaxStormTide_OC2km.png)
<img src="MaxStormTide_Global2km.png" width="1100" alt="hi" usemap="#mapname">
<map name="mapname">
    <area shape="rect" coords="250,170,350,270" href="MaxStormTide_NA2km.png" alt="Western North Atlantic">
    <area shape="rect" coords="450,125,500,200" href="MaxStormTide_WE2km.png" alt="Western Europe">
    <area shape="rect" coords="550,350,600,400" href="MaxStormTide_EA2km.png" alt="East Africa">
    <area shape="rect" coords="600,250,650,300" href="MaxStormTide_SA2km.png" alt="South Asia">
    <area shape="rect" coords="785,175,950,300" href="MaxStormTide_WP2km.png" alt="West Pacific">
    <area shape="rect" coords="785,400,1050,475" href="MaxStormTide_OC2km.png" alt="Oceania">
</map>


### Meteorologic: Maximum 10-m Winds and Minimum Sea Surface Pressure
![GlobalGFS](MaxWindVel_Global2km.png)

# Archived Events

- [Tropical Cyclone Fani](Archives/Fani/Fani.md)
- [Tropical Cyclone Idai](Archives/Idai/Idai.md)

## How are the Forecasts Obtained?

Forecasts are 2D barotropic ocean circulation and inundation simulations on unstructured triangular meshes subject to meteorological and astronomical forcings, which drive surge and tide respectively. The simulations are conducted using the [ADCIRC](http://adcirc.org/) model. 

The meshes have been automatically generated using the [OceanMesh2D](https://github.com/CHLNDDEV/OceanMesh2D) Matlab meshing toolbox. A single seamless unstructured mesh is used for each forecast. The default mesh which covers the entire Earth has a variable coastal resolution ranging between 2 km and 10 km depending on shoreline complexity. Moreover, when a storm is predicted to make landfall a higher resolution (~90 m) inset around the forecasted landfalling region is automatically merged into the global mesh to provide accurate forecasts of extreme water levels and flooding in the landfall region. In this way we can minimize the computational resources in order to provide timely forecasts without sacrificing accuracy where coastal flooding occurs.

Nearly 1400 high-resolution (~90 m) 1 deg x 1 deg inset meshes (indicated by the red boxes in the image below) have been generated in regions where storms and flooding tend to occur. These are automatically merged into the global mesh as necessary. 
![SRTMBoxes](BoxMap_SRTM3.png)

### Inputs and Sources
- Meteorology: [FV3-GFS](https://www.emc.ncep.noaa.gov/users/Alicia.Bentley/fv3gfs/) model 10-m wind velocities (U10 and V10) and atmospheric pressure reduced to mean sea level (PRMSL). [Link for latest 2-day - archive of forecasts](https://para.nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/para/)
- Topography/Bathymetry: Default for the Earth: [SRTM15+V2.0](https://topex.ucsd.edu/WWW_html/srtm15_plus.html) (~450 m); for high-resolution insets topography is replaced with [SRTM3](https://dds.cr.usgs.gov/srtm/version2_1/SRTM3/) (~90 m) data.
- Shoreline Geometry: Default for the Earth: [GSSHG](http://www.soest.hawaii.edu/wessel/gshhg/); for high-resolution insets shoreline is replaced with the [SWBD](https://dds.cr.usgs.gov/srtm/version2_1/SWBD/) (~30-90 m accuracy) SRTM-based dataset.

<!---
![GlobalStormTide](MaxStormTide_Global2km.png)
https://wpringle.github.io/Advanced-Global-Coastal-Flood-Forecasting-System/
## Welcome to GitHub Pages

You can use the [editor on GitHub](https://github.com/WPringle/Advanced-Global-Coastal-Flood-Forecasting-System/edit/master/README.md) to maintain and preview the content for your website in Markdown files.

Whenever you commit to this repository, GitHub Pages will run [Jekyll](https://jekyllrb.com/) to rebuild the pages in your site, from the content in your Markdown files.

### Markdown

Markdown is a lightweight and easy-to-use syntax for styling your writing. It includes conventions for

```markdown
Syntax highlighted code block

# Header 1
## Header 2
### Header 3

- Bulleted
- List

1. Numbered
2. List

**Bold** and _Italic_ and `Code` text

[Link](url) and ![Image](src) 
```

For more details see [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).

### Jekyll Themes

Your Pages site will use the layout and styles from the Jekyll theme you have selected in your [repository settings](https://github.com/WPringle/Advanced-Global-Coastal-Flood-Forecasting-System/settings). The name of this theme is saved in the Jekyll `_config.yml` configuration file.

### Support or Contact

Having trouble with Pages? Check out our [documentation](https://help.github.com/categories/github-pages-basics/) or [contact support](https://github.com/contact) and we’ll help you sort it out.
-->

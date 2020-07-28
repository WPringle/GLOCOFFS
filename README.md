# Latest 6-hourly Forecasts

<!---
## Hydrodynamic: Maximum Storm Tide (Surge + Astronomical Tide) Anomaly

Anomaly from Highest Astronomical Tide (HAT); estimated by the maximum water level from a 1-year (2018) tide-only simulation
-->

DISCLAIMER: This model is under development and predictions for surge and coastal flooding are for research purposes only. They should never be used for navigational purposes or emergency planning under any circumstances.

## Hydrodynamic: Maximum Surge (meteorological driven component above tides)

Click to see closeup of maximum surge and maximum winds/minimum pressure in individual regions

[WA](MaxCombined_WA1.5km.png) ・ [NA](MaxCombined_NA1.5km.png) ・ [EU](MaxCombined_EU1.5km.png) ・ [EA](MaxCombined_EA1.5km.png) ・ [SA](MaxCombined_SA1.5km.png) ・ [WP](MaxCombined_WP1.5km.png) ・ [OC](MaxCombined_OC1.5km.png)
<img src="MaxStormTide_Global1.5km.png" width="1100" alt="hi" usemap="#mapname">
<map name="mapname">
    <area shape="rect" coords="150,100,200,150" href="MaxCombined_WA1.5km.png" alt="Western Alaska">
    <area shape="rect" coords="250,170,350,270" href="MaxCombined_NA1.5km.png" alt="Western North Atlantic">
    <area shape="rect" coords="480,120,600,230" href="MaxCombined_EU1.5km.png" alt="Europe">
    <area shape="rect" coords="575,325,650,400" href="MaxCombined_EA1.5km.png" alt="East Africa">
    <area shape="rect" coords="650,200,750,275" href="MaxCombined_SA1.5km.png" alt="South Asia">
    <area shape="rect" coords="750,175,875,275" href="MaxCombined_WP1.5km.png" alt="West Pacific">
    <area shape="rect" coords="750,325,950,450" href="MaxCombined_OC1.5km.png" alt="Oceania">
</map>


## Meteorologic: Maximum 10-m Winds and Minimum Sea Surface Pressure
![GlobalGFS](MaxWindVel_Global1.5km.png)

# Archived Events
- [Tropical Cyclone Fani](Archives/Fani/Fani.md)
- [Tropical Cyclone Idai](Archives/Idai/Idai.md)

## How are the Forecasts Obtained?

Forecasts are 2D barotropic ocean circulation and inundation simulations on unstructured triangular meshes subject to meteorological and astronomical forcings, which drive surge and tide respectively. The effect of ice is considered in the computationa of sea surface drag driving surge. The simulations are conducted using the Version 55 of the [ADCIRC](http://adcirc.org/) model ([Pringle et al., 2020](https://doi.org/10.5194/gmd-2020-123)), and each forecast simulation takes ~10 min wall-clock time on 96 computational processors.

The meshes have been automatically generated using the [OceanMesh2D](https://github.com/CHLNDDEV/OceanMesh2D) Matlab meshing toolbox ([Roberts et al., 2019](https://doi.org/10.5194/gmd-12-1847-2019)). A single seamless unstructured mesh is used for each forecast. The default mesh which covers the entire Earth has a coastal resolution of 1.5 km. In the ocean the resolution varies between 1.5 km and 25 km according to functions of topographic gradient and distance from the shoreline.

NOTE: For the explanation below see archived events for examples of using high-resolution insets in the global mesh. The automatic 6-hourly forecasts are currently only simulated on the default global mesh without high-resolution insets 

Moreover, when a storm is predicted to make landfall a higher resolution (~90 m) inset around the forecasted landfalling region is automatically merged into the global mesh to provide accurate forecasts of extreme water levels and flooding in the landfall region. In this way we can minimize the computational resources in order to provide timely forecasts without sacrificing accuracy where coastal flooding occurs.

Nearly 1400 high-resolution (~90 m) 1 deg x 1 deg inset meshes (indicated by the red boxes in the image below) have been generated in regions where storms and flooding tend to occur. These are automatically merged into the global mesh as necessary. 
![SRTMBoxes](BoxMap_SRTM3.png)

## Inputs and Sources
- Meteorology: [FV3-GFS](https://www.emc.ncep.noaa.gov/users/Alicia.Bentley/fv3gfs/) model 10-m wind velocities (U10 and V10) and atmospheric pressure reduced to mean sea level (MSLET). [Link for latest 10-day - archive of forecasts](https://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/)
- Topography/Bathymetry: Default for the Earth: [GEBCO_2019](https://www.gebco.net/data_and_products/gridded_bathymetry_data/gebco_2019/gebco_2019_info.html) (~450 m); for high-resolution insets topography is replaced with [SRTM3](https://dds.cr.usgs.gov/srtm/version2_1/SRTM3/) (~90 m) data.
- Shoreline Geometry: Default for the Earth: [GSSHG](http://www.soest.hawaii.edu/wessel/gshhg/); for high-resolution insets shoreline is replaced with the [SWBD](https://dds.cr.usgs.gov/srtm/version2_1/SWBD/) (~30-90 m accuracy) SRTM-based dataset.

## References
- Pringle, W. J., Wirasaet, D., Roberts, K. J., and Westerink, J. J.: Global Storm Tide Modeling with ADCIRC v55: Unstructured Mesh Design and Performance, Geosci. Model Dev. Discuss., https://doi.org/10.5194/gmd-2020-123, in review, 2020.
- Pringle, W. J., Wirasaet, D., Westerink, J. J., and Roberts, K. J.: ADCIRC v55 - Modeling the Earth, Mesh Resolution Effects and Removing Time Step Contraints, in ADCIRC Users Group Meeting 2020, https://doi.org/10.17615/39bf-wa56, 2020.
- Roberts, K. J., Pringle, W. J., and Westerink, J. J.: OceanMesh2D 1.0: MATLAB-based software for two-dimensional unstructured mesh generation in coastal ocean modeling, Geosci. Model Dev., 12, 1847–1868, https://doi.org/10.5194/gmd-12-1847-2019, 2019.

## Other Links
- Please also check out our dedicated [Alaska forecasts](https://gm-ling.github.io/AKSSFS/)

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

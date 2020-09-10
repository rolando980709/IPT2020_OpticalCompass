% --------Inputs---------
year = 2020;
month = 2;
day = 29;
hour = 17;
mins = 50;

lat = 7;
lon = -73;
GMTOffset = -5;

% alternative to select lat, lon, GMTOffset
% [lat,lon,GMTOffset] = MapSelectCoords();

tilt = 30; % tards equator is positive 
pnlAzim = 30; % zero is due north, rotating clockwise

% ------------------------

% To test function used within the function polarPlotSolarPath
% [elev,azim,decl,HRA] = calcSolarPath(year,month,day,hour,mins,GMTOffset,lat,lon);

% To plot the solar path in polar axes
% (This will return values needed for the function horizonRF3DPlot)
figure
[azimLArr, elevLArr, azimP, elevP] = ...
    polarPlotSolarPath(year,month,day,hour,mins,GMTOffset,lat,lon);

% To plot the horizon reference frame 
figure
horizonRF3DPlot(azimLArr,elevLArr,azimP,elevP,tilt,pnlAzim);

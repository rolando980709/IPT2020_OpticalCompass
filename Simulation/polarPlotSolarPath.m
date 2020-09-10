% POLARPLOTSOLARPATH plots the sun path (azimuth and elevation) in a polar plot
% Created by JY Wong 30.04.2018

function [azimLArr, elevLArr, azimP, elevP] = ...
    polarPlotSolarPath(year,month,day,hour,mins,GMTOffset,lat,lon)
format long 

%{
year = 2018;
month = 12;
day = 1;
hour = 12;
mins = 45;
GMTOffset = 10;
lat = 40;
lon = 135;
%}

% Preallocating size to improve performance
hourRange = 0:0.1:24; 
% Extend range by plus minus 24 
% To accomodate for the placement of wrongly set GMTOffset
elevLArr = ones(1, numel(hourRange)).*-1;
azimLArr = ones(1, numel(hourRange)).*-1;
hoursArr = ones(1, numel(hourRange)).*-1;
idx = 1;

% evaluate the point on the solar path line
for hours = hourRange
    [elevL, azimL] = calcSolarPath(year,month,day,hours,0,GMTOffset,lat,lon);
    if elevL >= 0 && elevL <= 90
        elevLArr(idx) = elevL;
        azimLArr(idx) = azimL;
        hoursArr(idx) = hours;
        % polarplot(deg2rad(azimL),90-elevL,'x') % Plot individual points
        % hold on
        idx = idx + 1;
    end
end

elevLArr(elevLArr == -1) = [];
azimLArr(azimLArr == -1) = [];
% hoursArr(hoursArr == -1) = [];
display(elevLArr)
display(azimLArr)

[elevP, azimP] = calcSolarPath(year,month,day,hour,mins,GMTOffset,lat,lon);

% Adjustment to be placed in polar plot
% Note: 1) In polarplot, theta is in radians
% 2) "elevation (or altitude) angle is calculated from the horizontal"
% the polar plot we want is zero at the outside (rho) and increasing
% towards the centre, MATLAB polarplot does not have this feature, so we
% cheat by inverting the value (minus 90) and changing the rho labels

azimLArrpp = deg2rad(azimLArr);
azimPpp = deg2rad(azimP);
elevLArrpp = 90 - elevLArr;
elevPpp = 90 - elevP;

% Polar plot
% figure
polarplot(azimLArrpp,elevLArrpp)
title('Solar Path')
hold on
polarplot(azimPpp,elevPpp,'x')
%rlim([0 90])
hold off


pax = gca;
pax.ThetaZeroLocation = 'top';
pax.ThetaDir = 'clockwise';
pax.RTick = [0 10 20 30 40 50 60 70 80 90];
pax.RTickLabel = {'90';'';'';'60';'';'';'30';'';'';'0'};

% Cartesian Plot for troubleshooting
% figure
% plot(azimLArr,elevLArr)

%{
% For troubleshootinh
figure
plot(hoursArr,azimLArr)
hold on
plot(hoursArr,elevLArr)
pltax = gca;
pltax.XTick = 0:2:24;
title('Daily variation of the solar angles')
legend('azim','elev')
xlabel('hours')
ylabel('degree')
hold off
%}
end




    
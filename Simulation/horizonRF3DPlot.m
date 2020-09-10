% HORIZONRF3DPLOT plots the horizon reference frame to illustrate the
% position of the Sun and the solar panel on Earth
% Created by JY Wong 01.05.2018
function horizonRF3DPlot(azimLArr,elevLArr,azimP,elevP,tilt,pnlAzim)
rhoSph = 2;
% azimuth angle in matlab in counterclockwise while conventional solar 
% angles is in clockwise, use 360 - angle to convert this
azimLArrRad = deg2rad(360 - azimLArr);
elevLArrRad = deg2rad(elevLArr);
azimPRad = deg2rad(360 - azimP);
elevPRad = deg2rad(elevP);

% Plot the solar path
[xSP,ySP,zSP] = sph2cart(azimLArrRad,elevLArrRad,rhoSph);
% figure
plot3(xSP,ySP,zSP,'LineWidth',2,'Color','b');
hold on

title('Horizon Reference Frame')

% Plot the "hemisphere"
% N for linspace made same as length of azimLArr (solar path points)
thetaHSph = linspace(0,2*pi);
phiHSph = linspace(0,pi/2); 
% Matlab sph coords uses phi from the horizontal plane, not from the +ve z axis
[thetaSphMesh, phiSphMesh] = meshgrid(thetaHSph,phiHSph);
[xHSph,yHSph,zHSph] = sph2cart(thetaSphMesh,phiSphMesh,rhoSph);
%{
% does not seem to work (AlphaData,FaceAlpha) when the 2nd surf comes in
a = ones(size(zHSph)).*0.5;
hSphAx = surf(xHSph,yHSph,zHSph,...
    'AlphaData',a,'FaceAlpha','flat','FaceColor',[.6 1 1],...
    'EdgeColor','none');
%}
hSphAx = surf(xHSph,yHSph,zHSph,...
    'FaceColor',[.6 1 1],'EdgeColor','none');
alpha(hSphAx,.2)
hold on

% Plot the "sphere lines"
[xHor,yHor,zHor] = sph2cart(thetaHSph,zeros(size(phiHSph)),rhoSph);
plot3(xHor,yHor,zHor,'LineWidth',1.5,'Color',[1 .87 0])
fHorPlane = fill3(xHor,yHor,zHor,[.7 1 .156],'EdgeColor','none');
alpha(fHorPlane,0.2)
[xVer,yVer,zVer] = sph2cart(zeros(size(thetaHSph)),linspace(0,pi),rhoSph);
plot3(xVer,yVer,zVer,'LineWidth',1.5,'Color',[1 .87 0])
hold on

% Calculate Cartesian coordinates for the position of the Sun's centre
[xSunC,ySunC,zSunC] = sph2cart(azimPRad,elevPRad,rhoSph);
%plot3(xSunC,ySunC,zSunC,'o')
hold on

% Plot the sun
thetaSun = linspace(0,2*pi);
phiSun = linspace(-pi/2,pi/2); 
rhoSun = 0.25;
[thetaSunMesh,phiSunMesh] = meshgrid(thetaSun,phiSun);
[xSun,ySun,zSun] = sph2cart(thetaSunMesh,phiSunMesh,rhoSun);
% b = ones(size(zSun));
s = surf(xSun+xSunC,ySun+ySunC,zSun+zSunC,...
    'FaceColor',[1 .92 0],'EdgeColor','none');
alpha(s,1);
hold on

%plot circulo concentrico 
%[xcirsun,ycirsun,zcirsun] = sph2cart(thetaHSph,zeros(size(phiHSph)),0.7);
%poscir = [xcirsun ycirsun zcirsun] .*rotz(90-elevPRad)
%anglez = 90 - rad2deg(elevPRad);
%Xcirsun = xcirsun*cos(deg2rad(anglez)) + ycirsun*sin(deg2rad(anglez));
%Ycirsun = -xcirsun*sin(deg2rad(anglez)) + ycirsun*cos(deg2rad(anglez));
%Zcirsun =  zcirsun;
%plot3(Xcirsun+xSunC,Ycirsun+ySunC,Zcirsun+zSunC,'LineWidth',1.5,'Color',[1 .78 0])
%anglez = 90 - rad2deg(elevPRad);
%Xcirsun = xcirsun*cos(deg2rad(anglez)) - zcirsun*sin(deg2rad(anglez));
%Ycirsun = ycirsun;
%Zcirsun =  xcirsun*sin(deg2rad(anglez)) + zcirsun*cos(deg2rad(anglez));

%vector penpendicular 
angle_ns = azimPRad-pi/2;
angle_ew = azimPRad-pi;
N_in = 360-rad2deg(angle_ns);

if N_in > 0 &&  N_in <= 90
   DN_in = strcat(num2str(N_in),' by N')
end

if N_in > 90 &&  N_in <= 180
   DN_in = strcat(num2str(-(180-N_in)),' by S')
end

if N_in > 180 &&  N_in <= 270
   DN_in = strcat(num2str(N_in-180),' by S')
end

if N_in > 270 &&  N_in <= 360
   DN_in = strcat(num2str(-360+N_in),' by N')
end





[xSP_o,ySP_o,zSP_o] = sph2cart(angle_ns,linspace(0,pi/2),rhoSph);
[xSP_p,ySP_p,zSP_p] = sph2cart(angle_ew,linspace(0,pi/2),rhoSph);
[xSP_s,ySP_s,zSP_s] = sph2cart(azimPRad,linspace(0,pi),rhoSph);
% figure
plot3(xSP_o,ySP_o,zSP_o,'LineWidth',2,'Color','R');
%plot3(xSP_p,ySP_p,zSP_p,'LineWidth',2,'Color','M');
%plot3(xSP_s,ySP_s,zSP_s,'LineWidth',2,'Color','g');

hold on

%zona de no visión 
%{
thetaHSphz = linspace(0,2*pi);
phiHSphz = linspace(1.074,pi/2); 
% Matlab sph coords uses phi from the horizontal plane, not from the +ve z axis
[thetaSphMeshz, phiSphMeshz] = meshgrid(thetaHSphz,phiHSphz);
[xHSphz,yHSphz,zHSphz] = sph2cart(thetaSphMeshz,phiSphMeshz,rhoSph);

hSphAx = surf(xHSphz,yHSphz,zHSphz,...
    'FaceColor',[0 0.4470 0.7410],'EdgeColor','none');
%alpha(hSphAx,.2)
hold on

%}

% Plot the solar panel
%xPanel = [-1 1 1 -1 -1].*.25;
%yPanel = [-1 -1 1 1 -1].*.33;
%zPanel = zeros(size(yPanel));
%pnlplt = plot3(xPanel,yPanel,zPanel);
%pnlfill = fill3(xPanel,yPanel,zPanel,'b');

% Plot the incident ray from the sun to the solar panel
%plot3([xSunC 0],[ySunC 0],[zSunC 0],'LineWidth',1)
% iTxtFac = .5;
% text(xSunC*iTxtFac,ySunC*iTxtFac,zSunC*iTxtFac,'incident ray')

% Plot the normal of the solar panel
%E = [0 -1 0];
%N = [1 0 0];
%Z = [0 0 1];
%n = (sind(tilt)*sind(pnlAzim)).*E + (sind(tilt)*cosd(pnlAzim)).*N ...
 %   + cosd(tilt).*Z;
%n = n.*2;
%plot3([n(1) 0],[n(2) 0],[n(3) 0],'LineWidth',1)
% nTxtFac = .5;
% text(n(1)*nTxtFac,n(2)*nTxtFac,n(3)*nTxtFac,'normal')

% Rotate panel according to tilt and panel azimuth
%rotate(pnlplt,[0 1 0],tilt,[0 0 0])
%rotate(pnlplt,[0 0 -1],pnlAzim,[0 0 0])
%rotate(pnlfill,[0 1 0],tilt,[0 0 0])
%rotate(pnlfill,[0 0 -1],pnlAzim,[0 0 0])


%detector
r = 0.2;
h = 0.3;
tt = linspace(0, 2*pi);
cyl = [r*cos(tt); r*sin(tt)];
plot(cyl(1,:), cyl(2,:))
surf([cyl(1,:); cyl(1,:)], [cyl(2,:); cyl(2,:)], [-h*ones(1,size(cyl,2)) + h/2; h*ones(1,size(cyl,2))+ h/2])
plot3([0 0],[0 0],[0 2],'LineWidth',1,'Color','g')

%alpha(fPanel,0.8)
text(.3,0,.2,'Detector')

% Labels
plot3(0,0,2,'x')
text(0,0,rhoSph+.8,'zenith')
text(-3.3,2,rhoSph+1,strcat('\theta_r = ',num2str(N_in)))
text(-3.3,2,rhoSph+.6,strcat('\Delta \theta_r = ',num2str(DN_in)))
%text(-3.5,2,rhoSph+1,strcat('\theta_m = ',num2str(rad2deg(angle_ew))))
text(-3.3,2,rhoSph+0.2,strcat('\phi = ',num2str(rad2deg(azimPRad))))
xlabel('x');ylabel('y');zlabel('z')
text(rhoSph-.2,0,0,'N','FontSize',11)
text(-rhoSph+.2,0,0,'S','FontSize',11)
text(0,-rhoSph+.2,0,'E','FontSize',11)
text(0,rhoSph-.2,0,'W','FontSize',11)
hold on
axis equal off
view(3)

xlabel('x')
ylabel('y')
zlabel('z')
% axis on

hold off

end
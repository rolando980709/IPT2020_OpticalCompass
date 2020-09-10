az = importdata('Azimut_14_02_2020.txt');
el = 90 - importdata('elevacion_14_02_2020.txt');
t = importdata('hora_14_02_2020.txt');
E_w = 1:length(el);
E_W = E_w.'*0;

polarplot((az),el)
title('Solar Path')
hold on
%polarplot(azimPpp,elevPpp,'x')
rlim([0 90])
hold off


pax = gca;
pax.ThetaZeroLocation = 'top';
pax.ThetaDir = 'clockwise';
pax.RTick = [0 10 20 30 40 50 60 70 80 90];
pax.RTickLabel = {'90';'';'';'60';'';'';'30';'';'';'0'};
function out = enthalp(X,T)
%%
%% Enthalpy of a LiBr solution
%% After R. Muhumuza's "Modelling, Implementation and Simulation of a
%% Single-Effect Absorption Chiller in MERIT"
%%
%% Jose Albornoz
%% Fujitsu Laboratories of Europe
%% November 2011
%%
%% X = concentration
%% T = solution temperature, Celsius
%% 
%%

% table of enthalpies
% rows: temperatures from 20 to 100 Celsius, specified in 10 degree intervals
% columns: concentrations from 0 to 60% in 10% intervals
enth_raw = zeros(9,7);
enth_raw(1,:) = [84.0 67.4 52.6 40.4 33.5 38.9 78.0];
enth_raw(2,:) = [125.8 103.3 84.0 68.6 58.3 60.5 96.8];
enth_raw(3,:) = [167.6 139.5 115.8 96.0 82.5 82.2 115.4];
enth_raw(4,:) = [209.3 175.2 147.0 123.4 106.7 103.8 134.5];
enth_raw(5,:) = [251.1 211.7 179.1 151.4 131.7 125.8 153.7];
enth_raw(6,:) = [293.0 247.7 210.5 178.8 155.7 148.0 173.2];
enth_raw(7,:) = [334.9 297.8 243.6 207.3 181.0 170 192.6];
enth_raw(8,:) = [376.9 321.1 275.6 235.4 206.1 192.3 212.6];
enth_raw(9,:) = [419.0 357.6 307.9 263.8 231.0 214.6 231.5];

Xr = [0 0.1 0.2 0.3 0.4 0.5 0.6];

% obtains polynomial fits for enthalpies
fits = cell(1,9);
for i = 1:9
    fit = polyfit(Xr,enth_raw(i,:),4);
    fits{i} = @(z)(fit(1)*z.^4 + fit(2)*z.^3 + fit(3)*z.^2 + fit(4)*z + fit(5));
end

%figure(1)
%plot(Xr,enth_raw','*')
%hold on
%for i = 1:9
%    plot(Xr,fits{i}(Xr))
%end
%grid
%xlabel('Concentration')
%ylabel('Enthalpy (kJ/kg)')

% enthalpy estimate for other temperatures 
if T >= 20 && T < 30
    out = (fits{1}(X)*(30 - T) + fits{2}(X)*(T - 20))/10;
elseif T >= 30 && T < 40
    out = (fits{2}(X)*(40 - T) + fits{3}(X)*(T - 30))/10;   
elseif T >= 40 && T < 50
    out = (fits{3}(X)*(50 - T) + fits{4}(X)*(T - 40))/10;
elseif T >= 50 && T < 60
    out = (fits{4}(X)*(60 - T) + fits{5}(X)*(T - 50))/10;
elseif T >= 60 && T < 70
    out = (fits{5}(X)*(70 - T) + fits{6}(X)*(T - 60))/10;  
elseif T >= 70 && T < 80
    out = (fits{6}(X)*(80 - T) + fits{7}(X)*(T - 70))/10;
elseif T >= 80 && T < 90
    out = (fits{7}(X)*(90 - T) + fits{8}(X)*(T - 80))/10;   
elseif T >= 90 && T < 100
    out = (fits{8}(X)*(100 - T) + fits{9}(X)*(T - 90))/10;      
end

function h = enthalpies(X,Ts)
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
%% Ts = solution temperature, Celsius
%% 
%%
%clear all
%close all

% table of enthalpies
% rows: temperatures from 20 to 100 Celsius, specified in 10 degree intervals
% columns: concentrations from 0 to 60% in 10% intervals
enth_raw = zeros(7,7);
enth_raw(1,:) = [84.0 67.4 52.6 40.4 33.5 38.9 78.0];
enth_raw(2,:) = [125.8 103.3 84.0 68.6 58.3 60.5 96.8];
enth_raw(3,:) = [167.6 139.5 115.8 96.0 82.5 82.2 115.4];
enth_raw(4,:) = [209.3 175.2 147.0 123.4 106.7 103.8 134.5];
enth_raw(5,:) = [251.1 211.7 179.1 151.4 131.7 125.8 153.7];
enth_raw(6,:) = [293.0 247.7 210.5 178.8 155.7 148.0 173.2];
enth_raw(7,:) = [334.9 297.8 234.6 207.3 181.0 170 192.6];

% coefficients
A = zeros(1,5);
B = zeros(1,5);
C = zeros(1,5);

A(1) = -2024.33;
A(2) = 163.309;
A(3) = -4.88161;
A(4) = 6.302948e-2;
A(5) = -2.913705e-4;

B(1) = 18.2829;
B(2) = -1.1691757;
B(3) = 3.248041e-2;
B(4) = -4.034184e-4;
B(5) = 1.8520569e-6;

C(1) = -3.7008214e-2;
C(2) = 2.8877606e-3;
C(3) = -8.1313015e-5;
C(4) = 9.9116628e-7;
C(5) = -4.4441207e-9;

h = 0;
for i = 1:5
    h = h + A(i)*X^i + Ts*B(i)*X^i + Ts^2*C(i)*X^i;
end


%% chiller_2.m
%%
%% Design equation for a LiBr-water coling unit v2.0
%%
%%
%% Jose Albornoz
%% Fujitsu Laboratories of Europe
%% August 2011
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  UNITS
%%  1 ton = 3516.86 W
%%
%%
%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all

% input parameters

tg = 90;     % generator temperature, celsius
te = 7;     % evaporator temperature, celsius
tc = 40;     % condenser temperature, celsius
ta = 40;     % absorber temperature, celsius
EL = 0.8;      % liquid-liquid heat exchanger efficiency
QE = 100;    % cooling load, watts

% temporal, before switching to SI metric units
QE = QE/3516.86;   % cooling load, ton

QE = 3024; % 1 ton = 3024 kcal/h
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1) concentration of strong solution (absorber)
% must be between 0.5-0.65 kg LiBr/kg solution
X1 = (49.04 + 1.125*ta - te)/(134.65 + 0.47*ta)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 2) concentration of weak solution (generator)
% must be between 0.5-0.65 kg LiBr/kg solution
X4 = (49.04 + 1.125*tg - tc)/(134.65 + 0.47*tg)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% verifies concentration values

if ~(X4 > X1)
    error('LiBr2:concentrations','Incorrect concentration values: X4 < X1')
end

if ~(0.5 < X1 && X1 < 0.65)
    error('LiBr2:concentrations','Incorrect concentration value for X1')
end

if ~(0.5 < X4&& X4 < 0.65)
    error('LiBr2:concentrations','Incorrect concentration value for X4')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 3) enthalpy of liquid water at condenser output (kcal/kg)
H8 = tc - 25;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 4) enthalpy of saturated water vapor at evaporator output
% (kcal/kg)
H10 = 572.8 + 0.417*te;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 5) refrigerant flow rate (kg/h)
mR = QE/(H10 - H8);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 6) strong solution flow rate (kg/h)
mS = mR*X4/(X4 - X1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 7) weak solution flow rate (kg/h)
mW = mR*X1/(X4 - X1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 8) temperature of weak solution at heat exchanger exit (celsius)
t5 = tg - EL*(tg - ta);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 9) heat capacity of strong solution (kcal/(kg.C))
CX1 = 1.01 - 1.23*X1 + 0.48*X1^2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 10) heat capacity of weak solution (kcal/(kg.C))
CX4 = 1.01 - 1.23*X4 + 0.48*X4^2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 11) temperature of strong solution at heat exchanger exit
t3 = ta + (EL*X1*CX4*(tg - ta)/(X4*CX1));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 12) enthalpy of strong solution leaving the absorber (kcal/kg)
H1 = 42.81 - 425.92*X1 + 404.67*X1^2 + (1.01 - 1.23*X1 + 0.48*X1^2)*ta;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 13) enthalpy of weak solution entering absorber (kcal/kg)
H5 = 42.81 - 425.92*X4 + 404.67*X4^2 + (1.01 - 1.23*X4 + 0.48*X4^2)*t5;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 14) enthalpy of saturated water vapor leaving the generator (kcal/kg)
H7 = 572.8 + 0.46*tg - 0.043*tc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 15) heat that must be removed from condenser (kcal/h)
QC = mR*(H7 - H8);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 16) heat that must be supplied to the generator (kcal/h)
QG = mW*H5 + mR*H7 - mS*H1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 17) heat that must be released by the absorber (kcal/h)
QA = mW*H5 + mR*H10 - mS*H1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 18) coefficient of performance (COP)
COP = QE/QG;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 19) maximum coefficient of performance
COPmax = (te + 273.15)*(tg - ta)/((tg + 273.15)*(tc - te));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 20) relative performace ratio (RPR)
RPR = COP/COPmax;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 21) saturated water vapor pressure (mmHg) in evaporator
Pe = 10^(7.8853 - 1555/(te + 273.15) - 11.2414e4/(te + 273.15)^2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 22) saturated water vapor pressure (mmHg) in condenser
Pc = 10^(7.8853 - 1555/(tc + 273.15) - 11.2414e4/(tc + 273.15)^2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





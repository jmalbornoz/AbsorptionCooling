%% chiller_1.m
%%
%% Design equation for a LiBr-water coling unit v1.0
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

tg = 50;     % generator temperature, celsius
te = 15;     % evaporator temperature, celsius
tc = 20;     % condenser temperature, celsius
ta = 40;     % absorber temperature, celsius
El = 0.5;      % liquid-liquid heat exchanger efficiency
Qe = 100;    % cooling load, watts

% temporal, before switching to SI metric units
Qe = Qe/3516.86;   % cooling load, ton

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1) concentration of strong solution (absorber)
% must be between 0.5-0.65 kg LiBr/kg solution
X1 = (49.04 + 1.125*ta - te)/(134.65 + 0.47*ta)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 2) concentration of weak solution (generator)
% must be between 0.5-0.65 kg LiBr/kg solution
X4 = (49.04 + 1.125*tg - tc)/(134.65 + 0.47*tg)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 3a) saturated water vapor pressure (mmHg) in evaporator
Pe = 10^(7.8853 - 1555/(te + 273.15) - 11.2414e4/(te + 273.15)^2);

% 3b) saturated water vapor pressure (mmHg) in condenser
Pc = 10^(7.8853 - 1555/(tc + 273.15) - 11.2414e4/(tc + 273.15)^2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 4a) enthalpy of saturated liquid water (kcal/kg)
H8 = (tc - 25)

% 4b) enthalpy of saturated water vapor
H10 = 572.8 + 0.417*te;

% 4c) mass flow of weak LiBr solution (kg/s)
mw = (Qe/(H10 - H8))*(X1/(X4 - X1));

% 4d) mass flow of refrigerant (kg/s)
m8 = (Qe/(H10 - H8))*(X4/(X4 - X1));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 5a) specific heat of weak solution (kcal/(kg.C))
CX1 = 1.01 - 1.23*X1 + 0.48*X1^2;

% 5b) specific heat of strong solution (kcal/(kg.C))
CX4 = 1.01 - 1.23*X4 + 0.48*X4^2;

% 5c) t5: temperature in the weak solution circuit after the heat exchanger
t5 = tg - El*(tg - ta);

% 5d) H1: enthalpy of strong solution leaving absorber (kcal/kg)
H1 = 42.81 - 425.92*X1 + 404.67*X1^2 + (1.01 - 1.23*X1 + 0.48*X1^2)*ta;

% 5e) H5: enthalpy of weak solution entering absorber (kcal/kg)
H5 = 42.81 - 425.92*X4 + 404.67*X4^2 + (1.01 - 1.23*X4 + 0.48*X4^2)*t5;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 6a) H7: enthalpy of water vapor leaving the generator
% 4b) enthalpy of saturated water vapor
H7 = 572.8 + 0.417*tg;

% 6b) QG: heat required by generator
QG = Qe/(H10 - H8)*(X1*H5/(X4 - X1) + H7 - X4*H1/(X4 - X1));

% 6c) QA: heat released by the absorber
QA = Qe/(H10 - H8)*(X1*H5/(X4 - X1) + H10 - X4*H1/(X4 - X1));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 7) coefficient of performance
COP = (H10 - H8)*(X4 - X1)/(X1*H5 + (X4 - X1)*H7 - X4*H1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 8) maximum coefficient of performance
COPmax = te*(tg - ta)/(tg*(tc - te));








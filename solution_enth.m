%%
%%
%%
%%
clear all
close all

% test concentration and temperatures
%X = 0.5;
%T = 0:10:120;

X = 0:0.05:0.6;
T = 20;
 
%h1 = zeros(1,length(T));
%h2 = zeros(1,length(T));

h1 = zeros(1,length(X));
h2 = zeros(1,length(X));
h3 = zeros(1,length(X));

%for i = 1:length(T)
%    h1(i) = enthalpies(X,T(i));
%    h2(i) = (42.81 - 425.92*X + 404.67*X^2 + (1.01 - 1.23*X + 0.48*X^2)*T(i))*4.184;
%end

for i = 1:length(X)
    h1(i) = enthalpies(X(i),T);
    h2(i) = enthalp(X(i),T);
    h3(i) = (42.81 - 425.92*X(i) + 404.67*X(i)^2 + (1.01 - 1.23*X(i) + 0.48*X(i)^2)*T)*4.184;
end

figure(1)
plot(X,h2)
grid


T = 60;
X = 0.6;

%h = (42.81 - 425.92*X + 404.67*X^2 + (1.01 - 1.23*X + 0.48*X^2)*T)*4.184 + 266.7436

%figure(2)
%plot(T,(h2 - 321.5199)/4.184)
%grid


% entalphy at 25 Celsius (kJoule/kg)
%h_25 = (68.06 - 456.67*Xt + 416.67*Xt^2)*4.184 + 321.5199

% enthalpy at t Celsius (kJoule/kg)
%h_Tt = (42.81 - 425.92*Xt + 404.67*Xt^2 + (1.01 - 1.23*Xt + 0.48*Xt^2)*Tt)*4.184 + 321.5199

%delta_h = h_Tt - h_25

%h_25 = enthalpies(Xt,25 + 273)
%h_Tt = enthalpies(Xt,Tt + 273)
%delta_h = h_Tt - h_25


%%
%% Antonie equation: boiling point of water
%%
%%
%% Jose Albornoz
%% Fujitsu Laboratories of Europe
%% August 2011
%%
clear all 
close all

A = 8.07131;
B = 1730.63;
C = 233.426;

T = 0:0.5:120;

P = 10.^(A - B./(C + T));    % pressure in mmHg

P = P*0.001315789473684 ;        % pressure in atm

% this is the expression from F.L. Lansing (in mmHg)
PL = 10.^(7.8553 - 1555./(T + 273.15) - 11.2414e4./(T + 273.15).^2);

PL = PL*0.001315789473684 ;        % pressure in atm

figure(1)
plot(T,P,T,PL)
grid
xlabel('Boiling point (C)')
ylabel('Pressure (atm)')
legend('Antoine','Lansing')

P = 10:0.5:110;

T = B./(A - log10(P)) - C;

figure(2)
plot(P,T)
grid
xlabel('Pressure (mmHg)')
ylabel('Boiling point (C)')

T = 7

P = 10.^(A - B./(C + T))    % pressure in mmHg
%%
%% ACP vs TDP
%%
clear all
close all

% differences between ACP and TDP for AMD processors
x(1) = 0.2336;
x(2) = 0.3478;
x(3) = 0.3038;
x(4) = 0.3333;
x(5) = 0.25;
x(6) = 0.3043;
x(7) = 0.2353;
x(8) = 0.2105;
x(9) = 0.2308;
x(10) = 0.0858;

figure(1)
bar(x)
grid

mean(x)
std(x)

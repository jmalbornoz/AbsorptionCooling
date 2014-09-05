%%
%%   Absorption chiller dynamics 1
%%
%%
%%   Jose Albornoz
%%   Fujitsu Laboratories of Europe
%%   October 2011
%%
clear all
close all

x0=[-8 8 27];
tspan=[0,100];
[t,x]=ode45(@lorenz,tspan,x0);

figure(1)
plot3(x(:,1),x(:,2),x(:,3))


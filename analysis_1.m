%%
%% analysis_1.m
%%
%% Analysis of a LiBr chiller
clear all
close all
load temp_ranges

% heat exchanger efficiency
EL = 0.7;

% refrigeration load (watts)
QE = 100;

% secondary search procedure: we limit ourselves to those temperatures of
% practical interest
tg_sup = 65;    % upper generator temperature, celsius
tg_inf = 50;    % lower generator temperature, celsius
te_sup = 15;    % upper evaporator temperature, celsius
te_inf = 10;    % lower evaporator temperature, celsius

% criterion: tg_inf <= tg <= tg_sup, te_inf < te <= te_sup
temp2 = [];
for i = 1:size(temp1,1)
    if temp1(i,1) >= tg_inf && temp1(i,1) <= tg_sup && temp1(i,4) >= te_inf && temp1(i,4) <= te_sup
        temp2 = [temp2; temp1(i,1) temp1(i,2) temp1(i,3) temp1(i,4)];
    end
end

% fills vectors with chiller data
QG = [];
QC = [];
QA = [];
COP = [];
RPR = [];
mR = [];
mS = [];
mW = [];
Pe = [];
Pc = [];
X1 = [];
X4 = [];
for i = 1:size(temp2,1)
    Chiller(i) = LiBr_2(temp2(i,1),temp2(i,2),temp2(i,3),temp2(i,4),EL,QE);
    QG = [QG Chiller(i).QG];
    QC = [QC Chiller(i).QC];
    QA = [QA Chiller(i).QA];
    COP = [COP Chiller(i).COP];
    RPR = [RPR Chiller(i).RPR];
    mR = [mR Chiller(i).mR];
    mS = [mS Chiller(i).mS];
    mW = [mW Chiller(i).mW];
    Pe = [Pe Chiller(i).Pe];
    Pc = [Pc Chiller(i).Pc];
    X1 = [X1 Chiller(i).X1];
    X4 = [X4 Chiller(i).X4];    
end

figure(1)
plot(idx,temp2(:,1),idx,temp2(:,2),idx,temp2(:,3),idx,temp2(:,4))
axis([0 size(temp2,1) 0 70])
grid
legend('Tg','Tc','Ta','Te')

figure(2)
stem(idx,QG)
hold on
stem(idx,QA)
stem(idx,QC)
axis([0 size(temp2,1) 0 200])
grid
legend('QG','QA','QC')

figure(3)
plot(idx,COP,idx,RPR)
axis([0 size(temp2,1) 0 0.9])
grid
legend('COP','RPR')

figure(4)
plot(idx,mR,idx,mS,idx,mW)
axis([0 size(temp2,1) 0 0.5e4])
grid
legend('mR','mS','mW')

figure(5)
plot(idx,Pe,idx,Pc)
axis([0 size(temp2,1) 0 55])
grid
legend('Pe','Pc')

figure(6)
subplot(3,1,1)
plot(idx,temp2(:,1),idx,temp2(:,2),idx,temp2(:,3),idx,temp2(:,4))
axis([0 size(temp2,1) 0 70])
set(gca,'YTick',0:10:70)
grid
legend('Tg','Tc','Ta','Te')

subplot(3,1,2)
plot(idx,QG,idx,QA,idx,QC)
axis([0 160 80 200])
grid
legend('QG','QA','QC')

subplot(3,1,3)
plot(idx,mR,idx,mS,idx,mW)
axis([0 160 0 20])
grid
legend('mR','mS','mW')

figure(7)
subplot(2,1,1)
plot(idx,temp2(:,1),idx,temp2(:,2),idx,temp2(:,3),idx,temp2(:,4))
axis([0 size(temp2,1) 0 70])
set(gca,'YTick',0:10:70)
grid
legend('Tg','Tc','Ta','Te')

subplot(2,1,2)
plot(idx,X4-X1)
axis([0 size(temp2,1) 0 0.05])
grid
legend('X1-X4')

figure(8)
plot(idx,X4-X1)
axis([0 size(temp2,1) 0 0.05])
grid
legend('X1-X4')

figure(9)
plot(idx,(X4-X1)/max(X4-X1),idx,COP/max(COP),idx,mS/max(mS),'*')
axis([0 size(temp2,1) 0 1.05])
grid
legend('X4 - X1','COP','mS')

figure(10)
plot(idx,(X4-X1)/max(X4-X1),idx,COP/max(COP),idx,mS/max(mS),'*')
axis([46 110 0 1.05])
grid
legend('X4 - X1','COP','mS')

figure(11)
plot(idx,QG,idx,QA,idx,QC)
axis([46 110 80 400])
grid
legend('QG','QA','QC')



%%
%% analysis_2.m
%%
%% Analysis of a LiBr chiller
clear all
close all
load temp_ranges
%load temp_ranges_lowres

% heat exchanger efficiency
EL = 0.7;

% refrigeration load (watts)
QE = 90;
%QE = 40;
%QE = 80;
%QE = 107;
%QE = 123;

% secondary search procedure: we limit ourselves to those temperatures of
% practical interest
%tg_sup = 67;    % upper generator temperature, celsius
%tg_inf = 62;    % lower generator temperature, celsius
tg_sup = 75;    % upper generator temperature, celsius
tg_inf = 45;    % lower generator temperature, celsius
te_sup = 10.5;    % upper evaporator temperature, celsius
te_inf = 8.5;    % lower evaporator temperature, celsius

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
    if temp2(i,1) == 65 && temp2(i,2) == 36 && temp2(i,3) == 35 && temp2(i,4) == 12.5
        cheche = 1;
    end
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

Psearch = [];
for i = 1:size(temp2,1)
    %if QG(i) > 29.75 && QG(i) < 30.25 
    %if QG(i) > 149.75 && QG(i) < 150.25 
    %if QG(i) >= 99.75 && QG(i) <= 100.25   
    %if QG(i) > 49.75 && QG(i) < 50.25 
    %if QG(i) > 69.75 && QG(i) < 70.25 
    %if QG(i) > 89.75 && QG(i) < 90.25 
    %if QG(i) > 109.75 && QG(i) < 110.25         
    %if QG(i) > 129.75 && QG(i) < 130.25 
    if QG(i) > 108.75 && QG(i) < 109.25 
    %if QG(i) > 64.75 && QG(i) <= 65.25  
    %if QG(i) > 99.75 && QG(i) <= 100.25   
    %if QG(i) > 90 && QG(i) <= 110                            
        Psearch = [Psearch; QG(i) QC(i) QA(i) COP(i) temp2(i,1) temp2(i,2) temp2(i,3) temp2(i,4) mR(i) mS(i) mW(i) Pe(i) Pc(i) X4(i) X1(i)];
    end
end

%stem(Psearch(:,2))

idx = 1:size(Psearch,1);

figure(1)
plot(idx,Psearch(:,5),idx,Psearch(:,6),idx,Psearch(:,7),idx,Psearch(:,8))
axis([1 length(idx) 0 70])
ylabel('^{\circ}C')
xlabel('Values')
grid
legend('Tg','Tc','Ta','Te')

figure(2)
plot(idx,Psearch(:,1),idx,Psearch(:,2),idx,Psearch(:,3))
%axis([1 length(idx) 40 50])
ylabel('Watts')
xlabel('Values')
grid
legend('QG','QC','QA')

figure(3)
plot(idx,Psearch(:,4))
%axis([1 length(idx) 0.65 0.68])
xlabel('Values')
grid
legend('COP')

figure(4)
plot(idx,Psearch(:,9),idx,Psearch(:,10),idx,Psearch(:,11))
axis([1 length(idx) 0 12])
xlabel('Values')
ylabel('kg/hr')
grid
legend('mR','mS','mW')

figure(5)
plot(idx,Psearch(:,12),idx,Psearch(:,13))
axis([1 length(idx) 0 50])
xlabel('Values')
ylabel('mmHg')
grid
legend('Pe','Pc')

figure(6)
plot(idx,Psearch(:,14),idx,Psearch(:,15))
axis([1 length(idx) 0.49 0.6])
xlabel('Values')
ylabel('kg/kg')
grid
legend('X2','X1')

press = [Psearch(2,12) Psearch(2,13)];
for i = 4:6
    press = [press;Psearch(i,12) Psearch(i,13)];
end

%figure(7)
%plot(press)
%grid
%ylabel('Pressures (mmHg)')
%legend('Pe', 'Pc')







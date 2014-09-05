%%
%% Allowable temperature values for a LiBr chiller, v2.0
%%
%% Jose Albornoz
%% Fujitsu Laboratories of Europe
%% August 2011
%%
clear all
close all
tic

% temperature step
deltaT = 1;

tg = 0:deltaT:80;     % generator temperature, celsius
tc = 0:deltaT:80;     % condenser temperature, celsius
ta = 0:deltaT:80;     % absorber temperature, celsius
te = 0:deltaT:80;     % evaporator temperature, celsius

Lg = length(tg);
Lc = length(tc);
La = length(ta);
Le = length(te);

% we need to satisfy the following:
% tg > tc >= ta > te
% 0.5 <= X1 <= 0.65
% 0.5 <= X4 <= 0.65

% initial search procedure: temperatures that result in allowable solution concentration
% values
temp1 = [];
for i = 1:Lg
    for j = 1:Lc
        for k = 1:La
            for l = 1:Le
                if tg(i) > tc(j) && tc(j) >= ta(k) && ta(k) > te(l)
                    X4 = (49.04 + 1.125*tg(i) - tc(j))/(134.65 + 0.47*tg(i)); 
                    X1 = (49.04 + 1.125*ta(k) - te(l))/(134.65 + 0.47*ta(k));                    
                    if X4 > X1 && X4 > 0.5 && X4 < 0.65 && X1 > 0.5 && X1 < 0.65                       
                       temp1 = [temp1; tg(i) tc(j) ta(k) te(l)];
                    end
                end
            end
        end
    end
end

% allowable range of temperatures
tg_range = [min(temp1(:,1)) max(temp1(:,1))];
tc_range = [min(temp1(:,2)) max(temp1(:,2))];
ta_range = [min(temp1(:,3)) max(temp1(:,3))];
te_range = [min(temp1(:,4)) max(temp1(:,4))];

%save temp_ranges temp1
save temp_ranges_lowres temp1

listo = toc

% secondary search procedure: we limit ourselves to those temperatures of
% practical interest
%tg_sup = 65;    % upper generator temperature, celsius
%tg_inf = 50;    % lower generator temperature, celsius
%te_sup = 15;    % upper evaporator temperature, celsius
%te_inf = 10;    % lower evaporator temperature, celsius

%temp2 = [];
%for i = 1:size(temp1,1)
    %if temp1(i,1) >= tg_inf && temp1(i,1) <= tg_sup && temp1(i,4) >= te_inf && temp1(i,4) <= te_sup && temp1(i,2) == temp1(i,3)
%    if temp1(i,1) >= tg_inf && temp1(i,1) <= tg_sup && temp1(i,4) >= te_inf && temp1(i,4) <= te_sup
%        temp2 = [temp2; temp1(i,1) temp1(i,2) temp1(i,3) temp1(i,4)];
%    end
%end

%QG = [];
%QC = [];
%QA = [];
%COP = [];
%RPR = [];
%mR = [];
%mS = [];
%mW = [];
%Pe = [];
%Pc = [];
%for i = 1:size(temp2,1)
%    Chiller(i) = LiBr_2(temp2(i,1),temp2(i,2),temp2(i,3),temp2(i,4),EL,QE);
%    QG = [QG Chiller(i).QG];
%    QC = [QC Chiller(i).QC];
%    QA = [QA Chiller(i).QA];
%    COP = [COP Chiller(i).COP];
%    RPR = [RPR Chiller(i).RPR];
%    mR = [mR Chiller(i).mR];
%    mS = [mS Chiller(i).mS];
%    mW = [mW Chiller(i).mW];
%    Pe = [Pe Chiller(i).Pe];
%    Pc = [Pc Chiller(i).Pc];
%end

%idx = 1:size(temp2,1);

%figure(1)
%plot(idx,temp2(:,1),idx,temp2(:,2),idx,temp2(:,3),idx,temp2(:,4))
%grid
%legend('Tg','Tc','Ta','Te')

%figure(2)
%plot(idx,QG,idx,QA,idx,QC)
%grid
%legend('QG','QA','QC')

%figure(3)
%plot(idx,COP,idx,RPR)
%grid
%legend('COP','RPR')

%figure(4)
%plot(idx,mR,idx,mS,idx,mW)
%grid
%legend('mR','mS','mW')

%figure(5)
%plot(idx,Pe,idx,Pc)
%grid
%legend('Pe','Pc')

%figure(6)
%subplot(3,1,1)
%plot(idx,temp2(:,1),idx,temp2(:,2),idx,temp2(:,3),idx,temp2(:,4))
%grid
%legend('Tg','Tc','Ta','Te')

%subplot(3,1,2)
%plot(idx,QG,idx,QA,idx,QC)
%grid
%legend('QG','QA','QC')

%subplot(3,1,3)
%plot(idx,mR,idx,mS,idx,mW)
%axis([0 160 0 200])
%grid
%legend('mR','mS','mW')


%RPR_max = -100;
%COP_max = -100;
%for i = 1:size(temp2,1)
%    Ch = LiBr_2(temp2(i,1),temp2(i,2),temp2(i,3),temp2(i,4),EL,QE);
    %if COP > COP_max           
    %if COP > COP_max && temp(i,1) < 60 && temp(i,4) > 10 && temp(i,4) < 16 
    %if RPR > RPR_max 
    %if RPR > RPR_max && temp(i,1) == 60 && temp(i,2) == temp(i,3) && temp(i,4) < 16  
    %if RPR > RPR_max && temp(i,1) < 60 && temp(i,4) > 10 && temp(i,4) < 16      
%    if Ch.RPR > RPR_max         
    %if COP > COP_max && temp(i,1) == 60 && temp(i,4) < 15                            
        %COP_max = COP;
%        RPR_max = Ch.RPR;       
%    end
%end



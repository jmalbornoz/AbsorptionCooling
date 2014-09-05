%%
%% Allowable temperature values for a LiBr chiller, v2.0
%%
%% Jose Albornoz
%% Fujitsu Laboratories of Europe
%% August 2011
%%
clear all
close all

% heat exchanger efficiency
EL = 0.7;

% refrigeration load (watts)
QE = 100;

% temperature step
deltaT = 1;

tg = 25:deltaT:80;     % generator temperature, celsius
tc = 25:deltaT:40;     % condenser temperature, celsius
ta = 25:deltaT:40;     % absorber temperature, celsius
te = 0:deltaT:25;     % evaporator temperature, celsius

Lg = length(tg);
Lc = length(tc);
La = length(ta);
Le = length(te);

% we need to satisfy the following:
% tg > tc >= ta > te
% 0.5 <= X1 <= 0.65
% 0.5 <= X4 <= 0.65

% search procedure: temperature sets that result in allowable solution concentration
% values
temp = [];
for i = 1:Lg
    for j = 1:Lc
        for k = 1:La
            for l = 1:Le
                if tg(i) > tc(j) && tc(j) >= ta(k) && ta(k) > te(l)
                    X4 = (49.04 + 1.125*tg(i) - tc(j))/(134.65 + 0.47*tg(i)); 
                    X1 = (49.04 + 1.125*ta(k) - te(l))/(134.65 + 0.47*ta(k));                    
                    if X4 > X1 && X4 > 0.5 && X4 < 0.65 && X1 > 0.5 && X1 < 0.65                       
                       temp = [temp; tg(i) tc(j) ta(k) te(l)];
                    end
                end
            end
        end
    end
end

tg_range = [min(temp(:,1)) max(temp(:,1))]
tc_range = [min(temp(:,2)) max(temp(:,2))]
ta_range = [min(temp(:,3)) max(temp(:,3))]
te_range = [min(temp(:,4)) max(temp(:,4))]

save temp_ranges temp

RPR_max = -100;
%COP_max = -100;
for i = 1:size(temp,1)
    [QG QA QC COP RPR Pe Pc X1 X4] = LiBr_1(temp(i,1),temp(i,2),temp(i,3),temp(i,4),EL,QE);
    %if COP > COP_max           
    %if COP > COP_max && temp(i,1) < 60 && temp(i,4) > 10 && temp(i,4) < 16 
    %if RPR > RPR_max 
    %if RPR > RPR_max && temp(i,1) == 60 && temp(i,2) == temp(i,3) && temp(i,4) < 16  
    %if RPR > RPR_max && temp(i,1) < 60 && temp(i,4) > 10 && temp(i,4) < 16      
    if RPR > RPR_max && temp(i,1) == 60 && temp(i,4) < 15         
    %if COP > COP_max && temp(i,1) == 60 && temp(i,4) < 15                            
        %COP_max = COP;
        RPR_max = RPR;       
        R1 = [QG QA QC COP RPR Pe Pc X1 X4];
        R2 = [temp(i,1) temp(i,2) temp(i,3) temp(i,4)];
    end
end



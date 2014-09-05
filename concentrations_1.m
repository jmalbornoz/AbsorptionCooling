%%
%% Allowable temperature values for a LiBr chiller, v1.0
%%
%% Jose Albornoz
%% Fujitsu Laboratories of Europe
%% August 2011
%%
clear all
close all

tg = 0:1:80;     % generator temperature, celsius
tc = 0:1:80;     % condenser temperature, celsius
ta = 0:1:80;     % absorber temperature, celsius
te = 0:1:80;     % evaporator temperature, celsius

% we need tg > tc > ta > te and X4 > X1

L = length(tg);

% weak solution
X4 = zeros(L);
for i = 1:L
    for j = 1:L
        X4(i,j) = (49.04 + 1.125*tg(i) - tc(j))/(134.65 + 0.47*tg(i)); 
    end
end

%figure(1)
%surf(tg,tc,X4)
%xlabel('Tg')
%ylabel('Tc')
%zlabel('X4')

% strong solution
X1 = zeros(L);
for i = 1:L
    for j = 1:L
        X1(i,j) = (49.04 + 1.125*ta(i) - te(j))/(134.65 + 0.47*ta(i)); 
    end
end

%figure(2)
%surf(ta,te,X1)
%xlabel('Ta')
%ylabel('Te')
%zlabel('X1')

% weak solution, with restrictions
X4 = zeros(L);
for i = 1:L
    for j = 1:L
        temp = (49.04 + 1.125*tg(i) - tc(j))/(134.65 + 0.47*tg(i)); 
        if temp > 0.5 && temp < 0.65 && tg(i) > tc(j)
            X4(i,j) = 1;
        end
    end
end

%figure(1)
%surf(tg,tc,X4)
%xlabel('Tg')
%ylabel('Tc')
%zlabel('X4')

% strong solution, with restrictions
X1 = zeros(L);
for i = 1:L
    for j = 1:L
        temp = (49.04 + 1.125*ta(i) - te(j))/(134.65 + 0.47*ta(i));  
        if temp > 0.5 && temp < 0.65 && ta(i) > te(j)
            X1(i,j) = 1;
        end
    end
end

%figure(2)
%surf(ta,te,X1)
%xlabel('Ta')
%ylabel('Te')
%zlabel('X1')

temp = [];
for i = 1:L
    for j = 1:L
        for k = 1:L
            for l = 1:L
                %tempX4 = (49.04 + 1.125*tg(i) - tc(j))/(134.65 + 0.47*tg(i)); 
                %tempX1 = (49.04 + 1.125*ta(k) - te(l))/(134.65 + 0.47*ta(k));
                %if tempX4 > tempX1 && tempX4 > 0.5 && tempX4 < 0.65 && tempX1 > 0.5 && tempX1 < 0.65
                if tg(i) > tc(j) && tc(j) > ta(k) && ta(k) > te(l)
                    %if tg(i) > tc(j) && tc(j) > ta(k) && ta(k) > te(l)
                    tempX4 = (49.04 + 1.125*tg(i) - tc(j))/(134.65 + 0.47*tg(i)); 
                    tempX1 = (49.04 + 1.125*ta(k) - te(l))/(134.65 + 0.47*ta(k));                    
                    if tempX4 > tempX1 && tempX4 > 0.5 && tempX4 < 0.65 && tempX1 > 0.5 && tempX1 < 0.65                       
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



function xprime = tcase(t);
%tcase: linear rise in processor case temperature.

% temp_max: maximum case temperature in celsius
temp_max = 65:

% t_max: time required to reach maximum temperature in seconds
t_max = 10;

if t < 10
    tcase = temp_max*t/t_max;
elseif tcase >= 10
    tcase = temp_max;
end
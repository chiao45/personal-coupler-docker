function res = theta_exact(Re, Pr, k, x)
% reference Verstraete thesis, section 4
T_b = 310;
T_inf = 350;
v_inf = 0.1;
Re = @(X) v_inf*X/0.0002;
delta = @(X) 4.64*X./sqrt(Re(X))*(13/14)^(1/3)/(Pr^(1/3));
k = double(k);
z = @(X) 1.5/k*0.25./delta(X);
TW = @(X) T_b+(T_inf-T_b)*z(X)./(1+z(X));
res = (TW(x)-T_b)/(T_inf-T_b);
end
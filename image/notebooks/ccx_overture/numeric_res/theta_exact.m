function res = theta_exact(Re, Pr, k, x)
Re = sym(Re);
Pr = sym(Pr);
k = sym(k);
x = sym(x);
tau = 4* k/sqrt(Re*Pr);
a = erfc(tau*sqrt(x));
a = x.*tau^2+log(a);
res = 1-exp(a);
end
function res = theta_exact(Re, Pr, k, x)
tau = 4* k/sqrt(Re*Pr);
a = x.*tau^2+log(erfc(tau*sqrt(x)));
disp(a);
res = 1-exp(a);
end
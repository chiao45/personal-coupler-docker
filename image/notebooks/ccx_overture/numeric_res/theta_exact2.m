function res = theta_exact2(k, x, gamma)
Re = 500;
Pr = 100;
mu = 0.25*Pr^(1/3)*sqrt(Re)/(k*1.506);
theta_bar = 1/(1+mu);
V = integral(@(X)X.^gamma, 0, 1);
X = theta_bar/V;
res = X*x.^gamma;

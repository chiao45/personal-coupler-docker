## Heated Flow Over a Plate

#### Problem Description

Simple testing problem--flat plate problem for *conjugate heat transfer* (CHT). The parameters are:

* Fluid:
  * Re = 500
  * Pr = 0.01
  * rho = 1
  * kappa_f = kappa_s/k
  * U_inf = 0.1 m/s
  * L = 1m
  * T_inf = 350K

* Solid:
  * rho = 1
  * Cp = 100
  * kappa_s = 100
  * T_b = 310K

The simulation takes three levels of k: 1, 5, and 20.

####  Coupling Schemes

 * **FDSN**: Fluid Dirichlet and solid Neumann
 * **FDSR**: Fluid Dirichlet and solid Robin
 * **FNSD**: Fluid Neumann and solid Dirichlet
 * **FNSR**: Fluid Neumann and solid Robin
 * **FPSP**: Fluid pseudo Robin and solid pseudo Robin

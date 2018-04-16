$Kappa=20.0;
$solver="yale";
$rtol=1e-8;
$atol=1e-10;
$K=1.0;
$U_in=0.1;
$T_in=350.0;
$tFinal=.1;
$tPlot=.05;
$Re=500.0;
$fluidDensity=1.0;
$nu=0.0002;
$Pr=0.01;
$Alpha=0.02;
$grid="fluid_inputs/fluid_flat.hdf";
#
$grid
#
incompressible Navier Stokes
  Boussinesq model
  define real parameter kappa $Alpha
  define real parameter thermalExpansivity 0.0
  define real parameter adcBoussinesq 0.5
  continue
  #forward Euler
  implicit
  turn off twilight zone
  pde parameters
    nu $nu
    kThermal $Alpha
    thermal conductivity $Kappa
    fluid density
      $fluidDensity
    gravity
      0. -9.81 0.
  done
  OBPDE:second-order artificial diffusion 0
  OBPDE:ad21,ad22  1.0 1.0
  boundary conditions
    bcNumber1=inflowWithVelocityGiven, uniform(u=$U_in,T=$T_in)
    bcNumber4=outflow, mixedDerivative(0.*t+1.*t.n=0.)
    bcNumber2=slipWall, mixedDerivative(0.*t+1.*t.n=0.)
    bcNumber3=noSlipWall, mixedDerivative(0.*t+1.*t.n=0.)
    bcNumber100=noSlipWall, mixedDerivative(1.*t+0.*t.n=0.), userDefinedBoundaryData
      external temperature values
	$T_in
      done
    done
  done
  initial conditions
    uniform flow
      u=$U_in, v=0.0, p=103500.0, T=$T_in
    exit
  project initial conditions
  #do not project initial conditions
  continue
pressure solver options
    $solver
  relative tolerance
    $rtol
  absolute tolerance
    $atol
  exit
done

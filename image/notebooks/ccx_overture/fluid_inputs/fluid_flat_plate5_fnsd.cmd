$Kappa=20.0;
$solver="choose best iterative solver";
$rtol=1e-8;
$atol=1e-10;
$K=1.0;
$U_in=0.1;
$T_in=300.0;
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
  define real parameter adcBoussinesq 0.0
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
  OBPDE:second-order artificial diffusion 1
  OBPDE:ad21,ad22  1.0 1.0
  boundary conditions
    bcNumber1=inflowWithVelocityGiven, uniform(p=103500.0,u=$U_in,T=$T_in)
    bcNumber4=outflow, pressure(0.*p+1.*p.n=0.), mixedDerivative(0.*t+1.*t.n=0.)
    bcNumber2=slipWall, mixedDerivative(0.*t+1.*t.n=0.)
    bcNumber3=noSlipWall, mixedDerivative(0.*t+1.*t.n=0.)
    # do this for now... there is a bug in Overture CGINS implicit.C setting symmetric bc
    bcNumber99=slipWall, mixedDerivative(0.*t+1.*t.n=0.)
    bcNumber100=noSlipWall, mixedDerivative(0.*t+1.*t.n=0.), userDefinedBoundaryData
      external flux values
      	0.0
      done
    done
  done
  initial conditions
    uniform flow
      p=103500.0, u=$U_in, v=0.0, w=0.0, T=$T_in
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

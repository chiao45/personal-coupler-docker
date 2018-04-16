$Kappa=20.0;
$solver="yale";
$rtol=1e-4;
$atol=1e-4;
$iluLevels=0;
$ogesDebug=1;
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
  OBPDE:second-order artificial diffusion 1
  OBPDE:ad21,ad22  1.0 1.0
  boundary conditions
    bcNumber1=inflowWithVelocityGiven, uniform(u=$U_in,T=$T_in)
    bcNumber4=outflow, pressure(0.*p+1.*p.n=0.), mixedDerivative(0.*t+1.*t.n=0.)
    bcNumber2=slipWall, mixedDerivative(0.*t+1.*t.n=0.)
    bcNumber3=noSlipWall, mixedDerivative(0.*t+1.*t.n=0.)
    bcNumber100=noSlipWall, mixedDerivative(1.*t+1.*t.n=0.), userDefinedBoundaryData
      external robin coeffs
	310.0 400.0
      done
    done
  done
  pressure solver options
   $ogesSolver=$solver; $ogesRtol=$rtol; $ogesAtol=$atol; $ogesIluLevels=$iluLevels; $ogmgDebug=$ogesDebug; $ogesMaxIterations=100000;
   include $ENV{CG}/ins/cmd/ogesOptions.h
  exit
  initial conditions
    uniform flow
      p=103500.0, u=$U_in, v=0.0, T=$T_in
    exit
  #project initial conditions
  do not project initial conditions
  continue
done

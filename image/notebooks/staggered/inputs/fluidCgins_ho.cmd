$solver="choose best iterative solver"; $rtol=1.e-12; $atol=1.e-14;
$solver="yale";
$nu=.1; $kThermal=.3; $kappa=.1; $thermalExpansivity=.1; $degreeX=2; $degreeT=1; $debug=0;
$tFinal=.1; $tPlot=.05;
$ksp="bcgs"; $pc="bjacobi"; $subksp="preonly"; $subpc="ilu"; $iluLevels=1;
$grid="inputs/fluid_quad.hdf";
GetOptions( "g=s"=>\$grid,"tf=f"=>\$tFinal,"tp=f"=>\$tPlot,"degreeX=i"=>\$degreeX,"degreeT=i"=>\$degreeT );
$grid
  incompressible Navier Stokes
  Boussinesq model
  define real parameter thermalExpansivity $thermalExpansivity
  define real parameter adcBoussinesq 0.5
  continue
  #forward Euler
  adams PC
  compact finite difference
  OBTZ:polynomial
  OBTZ:twilight zone flow 0
  OBTZ:degree in space $degreeX
  OBTZ:degree in time $degreeT
  pressure solver options
     $solver
  relative tolerance
    $rtol
  absolute tolerance
    $atol
  debug
    0
  exit
  pde parameters
    nu $nu
    kThermal $kThermal
    thermal conductivity $kThermal
    gravity
      0. -9.8 0.
  done
  boundary conditions
    bcNumber1=noSlipWall, mixedDerivative(0.*t+1.*t.n=0.)
    # square(0,0)=outflow
    # square(0,1)=noSlipWall
    # square(1,1)=noSlipWall
    $cmd = "bcNumber2=noSlipWall, userDefinedBoundaryData\n external temperature values\n 0.0\n done\n";
    # $cmd = "bcNumber2=noSlipWall, userDefinedBoundaryData\n variable temperature\n 10.0 -10.0 0.5\n done\n";
    $cmd
  done
  initial conditions
    uniform flow
      u=0.0, v=0.0, p=1.0, T=0.
    exit
  project initial conditions
  continue
done
movie mode
finish

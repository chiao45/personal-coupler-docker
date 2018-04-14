#
# create a composite grids for flat plat CHT simulations
create mappings
  # the left inlet patch
  rectangle
    set corners
      -0.5 0.0 0.0 0.5
    mappingName
      INLET
    lines
      30 30
    boundary conditions
      1 0 2 2
  exit
  stretch coordinates
    stretch
      specify stretching along axis=0
     	layers
          1
          1. 3. 1.
      exit
    exit
  exit
  # the middle one
  rectangle
    set corners
      1.0 2.0 0.0 0.5
    mappingName
      MIDDLE
    lines
      40 30
    boundary conditions
      0 0 3 2
  exit
  stretch coordinates
    stretch
      specify stretching along axis=0
     	layers
          1
          1. 10. 0.
      exit
    exit
  exit
  # the outlet patch
  rectangle
    set corners
      2.0 3.0 0.0 0.5
    mappingName
      OUTLET
    lines
      30 20
    boundary conditions
      0 4 3 2
  exit
  # the interface patch
  rectangle
    set corners
      0.0 1.0 0.0 0.5
    lines
      100 50
    mappingName
      INTERFACE
    boundary conditions
      0 0 100 2
  exit
  stretch coordinates
    stretch
      specify stretching along axis=1
     	layers
          1
          1. 10. 0.
      exit
    exit
  exit
exit
generate an overlapping grid
# priority low-high
  stretched-MIDDLE
  stretched-INLET
  OUTLET
  stretched-INTERFACE
done choosing mappings
change parameters
  ghost points
    all
    2 2 2 2 2 2
  exit
  compute overlap
exit
save an overlapping grid
  fluid_flat.hdf
  fluid_flat
exit

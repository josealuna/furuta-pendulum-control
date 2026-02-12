# Furuta Pendulum Control with Julia / Control del Péndulo de Furuta con Julia

## [EN] Project Description
This project focuses on the research and implementation of **geometric control techniques** applied to the Furuta pendulum (rotational inverted pendulum). The goal is to explore how the geometric properties of the state space and the use of Riemannian manifolds can enhance robustness and stability in nonlinear mechanical systems.

### Objective
To investigate and develop control algorithms that leverage the intrinsic geometric structure of the system, enabling complex maneuvers such as swing-up and stabilization at the unstable equilibrium point.

### Simple Usage Example
To run a basic simulation, follow these steps in the Julia REPL:

1. **Activate the environment:**
   ```julia
   using Pkg
   Pkg.activate(".")
   Pkg.instantiate()

   include("src/main.jl")


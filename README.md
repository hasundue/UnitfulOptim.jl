# UnitfulOptim

This package enables [Optim.jl](https://github.com/JuliaNLSolvers/Optim.jl) package to handle the Quantity types implemented in [Unitful.jl](https://github.com/ajkeller34/Unitful.jl).

Note that this package has limited functionalities and is not well-tested so far.

## Usage

Currently, univariate optimization is only supported:

```julia
using Optim
opt = optimize(f, 1u"m", 5u"m")
xmin = minimizer(opt)
fmin = minimum(opt)
```

The resulting object of optimize() is UnitfulOptimizationResults, which wraps OptimizationResults object used in Optim package. Currently, the supported methods for this object are the followings:

- minimum
- minimizer

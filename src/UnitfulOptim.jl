module UnitfulOptim

using Unitful
import Unitful: Quantity, Units
import Optim: OptimizationResults
import Optim: optimize, minimizer, minimum

struct UnitfulOptimizationResults
    opt::OptimizationResults
    xunit::Units
    funit::Units
end

function optimize(f, a::Quantity, b::Quantity; kws...)
    c, d = promote(a, b)
    optimize(f, c, d; kws...)
end

function optimize{T<:Real,D,U}(f, a::Quantity{T,D,U}, b::Quantity{T,D,U}; kws...)
    g(x::T) = ustrip(f(x*U()))
    opt = optimize(g, ustrip(a), ustrip(b); kws...)
    UnitfulOptimizationResults(opt, U(), unit(f(a)))
end

for f in (:minimizer,)
    @eval function $f(uopt::UnitfulOptimizationResults)
        $f(uopt.opt) * uopt.xunit
    end
end

for f in (:minimum,)
    @eval function $f(uopt::UnitfulOptimizationResults)
        $f(uopt.opt) * uopt.funit
    end
end

end # module

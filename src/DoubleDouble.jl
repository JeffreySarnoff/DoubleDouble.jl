__precompile__()

module DoubleDouble

export Double, AccurateDouble, PerformantDouble

const SysFloat = Union{Float16, Float32, Float64}

# Algorithmic choice is a Trait
abstract type Trait end
abstract type Emphasis <: Trait end
struct Accuracy    <: Emphasis end
struct Performance <: Emphasis end

const EMPHASIS = Accuracy  # this is the default Emphasis

abstract type AbstractDouble{T} <: AbstractFloat end

struct Double{T<:SysFloat, E<:Emphasis} <: AbstractDouble{T}
    hi::T
    lo::T
end

function Double(::Type{E}, hi::T, lo::T) where {T<:SysFloat, E<:Emphasis}
    s = hi + lo
    e = (hi - s) + lo
    return Double{T,E}(s, e)
end

AccurateDouble(x)      = Double(Accuracy, x)
AccurateDouble(x, y)   = Double(Accuracy, x, y)

PerformantDouble(x)    = Double(Performance, x)
PerformantDouble(x, y) = Double(Performance, x, y)

@inline Double(hi::T, lo::T) where T<:SysFloat = Double(EMPHASIS, hi, lo)
@inline Double(x::T) where T<:SysFloat = Double(x, zero(T))
@inline Double(x::T) where T<:Real = Double(Float64(x))
@inline Double(x::T1, y::T2) where {T1<:Real, T2<:Real} = Double(Float64(x), Float64(y))

include("convert.jl")
include("compare.jl")
include("primitive.jl")

end # module

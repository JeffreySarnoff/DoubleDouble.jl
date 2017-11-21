__precompile__()

module DoubleDouble

export Double, FastDouble

const SysFloat = Union{Float16, Float32, Float64}

# Algorithmic choice is a Trait
abstract type Trait end
abstract type Emphasis <: Trait end
struct Accuracy    <: Emphasis end
struct Performance <: Emphasis end

const EMPHASIS     = Accuracy    # this is the default Emphasis
const ALT_EMPHASIS = Performance

const EMPHASIS_STR     = ""        # these are used in string()
const ALT_EMPHASIS_STR = "Fast"

abstract type AbstractDouble{T} <: AbstractFloat end

struct Double{T<:SysFloat, E<:Emphasis} <: AbstractDouble{T}
    hi::T
    lo::T
end

function Double(::Type{E}, hi::T) where {T<:SysFloat, E<:Emphasis}
    return Double{T,E}(hi, zero(T))
end

function Double(::Type{E}, hi::T, lo::T) where {T<:SysFloat, E<:Emphasis}
    s = hi + lo
    e = (hi - s) + lo
    return Double{T,E}(s, e)
end

Double(x)      = Double(Accuracy, x)
Double(x, y)   = Double(Accuracy, x, y)

FastDouble(x)    = Double(Performance, x)
FastDouble(x, y) = Double(Performance, x, y)

@inline Double(hi::T, lo::T) where T<:SysFloat = Double(EMPHASIS, hi, lo)
@inline Double(x::T) where T<:SysFloat = Double(x, zero(T))
@inline Double(x::T) where T<:Real = Double(Float64(x))
@inline Double(x::T1, y::T2) where {T1<:Real, T2<:Real} = Double(Float64(x), Float64(y))

include("convert.jl")
include("compare.jl")
include("primitive.jl")

Base.string(x::Double{T,EMPHASIS}) where T<:SysFloat = string(EMPHASIS_STR,"Double(",x.hi,", ",x.lo,")")
Base.string(x::Double{T,ALT_EMPHASIS}) where T<:SysFloat = string(ALT_EMPHASIS_STR,"Double(",x.hi,", ",x.lo,")")
Base.show(io::IO, x::Double{T,E}) where  {T<:SysFloat, E<:Emphasis} = print(io, string(x))

end # module

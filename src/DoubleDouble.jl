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

function Double(::Type{E}, hi::T, lo::T) where {T<:SysFloat, E<:Emphasis}
    s = hi + lo
    e = (hi - s) + lo
    return Double{T,E}(s, e)
end

function Double(::Type{E}, hi::T) where {T<:SysFloat, E<:Emphasis}
    return Double{T,E}(hi, zero(T))
end

function Double(::Type{E}, hi::T, lo::T) where {T<:Signed, E<:Emphasis}
    return Double(E, float(hi), float(lo))
end
function Double(::Type{E}, hi::T) where {T<:Signed, E<:Emphasis}
    return Double(E, float(hi), float(zero(T)))
end

function Double(::Type{E}, hi::T, lo::T) where {T<:Real, E<:Emphasis}
    s = Float64(hi + lo)
    e = Float64((hi - T(s)) + lo)
    return Double{Float64,E}(s,e)
end
function Double(::Type{E}, hi::T) where {T<:Real, E<:Emphasis}
    s = Float64(hi)
    e = Float64(hi - T(s))
    return Double{Float64,E}(s,e)
end

function Double(::Type{E}, hi::T, lo::T) where {T<:Rational, E<:Emphasis}
    return Double(E, BigFloat(hi), BigFloat(lo))
end
function Double(::Type{E}, hi::T) where {T<:Rational, E<:Emphasis}
    return Double(E, BigFloat(hi))
end


include("convert.jl")
include("compare.jl")
include("primitive.jl")

Base.string(x::Double{T,EMPHASIS}) where T<:SysFloat = string(EMPHASIS_STR,"Double(",x.hi,", ",x.lo,")")
Base.string(x::Double{T,ALT_EMPHASIS}) where T<:SysFloat = string(ALT_EMPHASIS_STR,"Double(",x.hi,", ",x.lo,")")
Base.show(io::IO, x::Double{T,E}) where  {T<:SysFloat, E<:Emphasis} = print(io, string(x))

end # module

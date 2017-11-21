import Base: (+), (-), (*), (/), div, fld, cld, rem, mod, sqrt

function (+)(a::Double{T,E}, b::T) where {T<:SysFloat, E<:Emphasis}
    hi, lo = two_sum(a.hi, b)
    lo += a.lo
    hi, lo = quick_two_sum(hi, lo)

    return Double(E, hi, lo)
end

+(a::T, b::Double{T,E}) where {T<:SysFloat, E<:Emphasis} = b + a
+(a::Signed, b::Double{T,E}) where {T<:SysFloat, E<:Emphasis} = b + float(a)
+(a::Double{T,E}, b::Signed) where {T<:SysFloat, E<:Emphasis} = a + float(b)

+(a::Double{T,E}, b::R) where {R<:Real, T<:SysFloat, E<:Emphasis} = +(promote(a,b)...)
+(a::R, b::Double{T,E}) where {R<:Real, T<:SysFloat, E<:Emphasis} = +(promote(a,b)...)
+(a::R, b::Double{T,E}) where {R<:Real, T<:SysFloat, E<:Emphasis} = +(promote(a,b)...)
+(a::Double{T,E}, b::R) where {R<:Real, T<:SysFloat, E<:Emphasis} = +(promote(a,b)...)

#=
    This is used for both Accuracy and Performance because addition and subtraction
    must be exact to preserve the numerical logic throughout.
=#

function (+)(x::Double{T, E}, y::Double{T, E}) where {T<:SysFloat, E<:Emphasis}
    s1, s2 = two_sum(x.hi, y.hi)
    t1, t2 = two_sum(x.lo, y.lo)
    s2 += t1
    s1, s2 = quick_two_sum(s1, s2)
    s2 += t2
    s1, s2 = quick_two_sum(s1, s2)
    return Double(E, s1, s2)
end

+(x::Double{T, E}, y::T) where {T<:SysFloat, E<:Emphasis} = (+)(x, Double(E, y))
+(x::T, y::Double{T, E}) where {T<:SysFloat, E<:Emphasis} = (+)(Double(E, x), y)
+(x::Double{T1, E}, y::Double{T2, E}) where {T1<:SysFloat, T2<:SysFloat, E<:Emphasis} =
    (+)(promote(x, y)...)
+(x::Double{T, E1}, y::Double{T, E2}) where {T<:SysFloat, E1<:Emphasis, E2<:Emphasis} =
    (+)(promote(x, y)...)
+(x::Double{T1, E1}, y::Double{T2, E2}) where {T1<:SysFloat, T2<:SysFloat, E1<:Emphasis, E2<:Emphasis} =
    (+)(promote(x, y)...)
   

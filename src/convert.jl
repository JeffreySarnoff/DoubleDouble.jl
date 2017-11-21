
Base.promote_rule(::Type{Double{T,Accuracy}}, ::Type{Double{T,Performance}}) where T<:SysFloat = Double{T,Accuracy}
Base.promote_rule(::Type{Double{Float64,E}}, ::Type{Double{Float32,E}}) where E<:Emphasis = Double{Float64,E}
Base.promote_rule(::Type{Double{Float64,E}}, ::Type{Double{Float16,E}}) where E<:Emphasis = Double{Float64,E}
Base.promote_rule(::Type{Double{Float32,E}}, ::Type{Double{Float16,E}}) where E<:Emphasis = Double{Float32,E}
Base.promote_rule(::Type{Double{T1,E1}}, ::Type{Double{T2,E2}}) where {T1<:SysFloat,T2<:SysFloat,E1<:Emphasis,E2<:Emphasis} =
   Double{promote_type(T1,T2), Accuracy}

Base.convert(::Type{Double{T,Accuracy}}, x::Double{T,Performance}) where T<:SysFloat = Double(Accuracy, x.hi, x.lo)
Base.convert(::Type{Double{T,Performance}}, x::Double{T,Accuracy}) where T<:SysFloat = Double(Performance, x.hi, x.lo)
Base.convert(::Type{Double{T,Accuracy}}, x::Double{T,Performance}) where T<:SysFloat = Double(Accuracy, x.hi, x.lo)
Base.convert(::Type{Double{T,Performance}}, x::Double{T,Accuracy}) where T<:SysFloat = Double(Performance, x.hi, x.lo)

const one32 = one(Float32)
const one64 = one(Float64)

@testset "Constructors" begin
    @test Double(one64) isa Double{Float64, EMPHASIS}
    @test Double{Float64}(1) isa Double{Float64, EMPHASIS}
    @test Double(1) isa Double{Float64, EMPHASIS}
    @test Double(1.0) isa Double{Float64, EMPHASIS}
    @test Double(Accuracy, 1.0) isa Double{Float64, Accuracy}
    @test Double(Performance, 1.0) isa Double{Float64, Performance}
    @test Double(Accuracy, one64) isa Double{Float64, Accuracy}
    @test Double(Performance, one64) isa Double{Float64, Performance}

    @test Double(one32) isa Double{Float32, EMPHASIS}
    @test Double{Float32}(1) isa Double{Float32, EMPHASIS}
    @test Double(Accuracy, 1.0f0) isa Double{Float32, Accuracy}
    @test Double(Performance, 1.0f0) isa Double{Float32, Performance}
    @test Double(1.0f0) isa Double{Float32, EMPHASIS}
    @test Double(Accuracy, one32) isa Double{Float32, Accuracy}
    @test Double(Performance, one32) isa Double{Float32, Performance}

    @test Double(π, Performance) isa Double{Float64, Performance}
    @test Double(π, Accuracy) isa Double{Float64, Accuracy}
    @test Double{Float32}(π, Performance) isa Double{Float32, Performance}
    @test Double{Float32}(π, Accuracy) isa Double{Float32, Accuracy}
    @test Double(big(π), Performance) isa Double{Float64, Performance}
    @test Double(big(π), Accuracy) isa Double{Float64, Accuracy}
    @test Double{Float32}(big(π), Performance) isa Double{Float32, Performance}
    @test Double{Float32}(big(π), Accuracy) isa Double{Float32, Accuracy}
    @test Double(1//3, Performance) isa Double{Float64, Performance}
    @test Double(1//3, Accuracy) isa Double{Float64, Accuracy}
    @test Double{Float32}(1//3, Performance) isa Double{Float32, Performance}
    @test Double{Float32}(1//3, Accuracy) isa Double{Float32, Accuracy}
end

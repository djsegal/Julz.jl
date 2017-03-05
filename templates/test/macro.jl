@testset "{{ title }} Macro Tests" begin

  @test isdefined({{ app }}, Symbol("@{{ name }}")) == true

end

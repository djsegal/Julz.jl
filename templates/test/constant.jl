@testset "{{ title }} Constant Tests" begin

  @test isdefined({{ app }}, :{{ name }}) == true

end

@testset "{{ title }} Function Tests" begin

  @test isdefined({{ app }}, :{{ name }}) == true

end

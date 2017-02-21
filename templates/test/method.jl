@testset "{{ title }} Method Tests" begin

  @test isdefined({{ app }}, :{{ name }}) == true

end

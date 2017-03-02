@testset "{{ title }} Type Tests" begin

  @test isdefined({{ app }}, :{{ class }}) == true

end

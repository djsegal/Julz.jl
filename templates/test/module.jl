@testset "{{ title }} Module Tests" begin

  @test isdefined({{ app }}, :{{ class }}) == true

end

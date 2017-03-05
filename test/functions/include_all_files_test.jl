@testset "Include All Files Function Tests" begin

  @test isdefined(Julz, :include_all_files) == true

  initial_dir = pwd()

  cd("dummy")

  Julz.generate("function", "baz")

  @test isdefined(:baz) != true

  Julz.include_all_files("$(pwd())/src/functions")

  @test isdefined(:baz) == true

  Julz.destroy("function", "baz")

  cd(initial_dir)

end

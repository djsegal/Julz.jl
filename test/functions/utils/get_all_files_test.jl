@testset "Get All Files Function Tests" begin

  @test isdefined(Julz, :get_all_files) == true

  initial_dir = pwd()

  cd("dummy")

  @test length(Julz.get_all_files("src")) == 1
  @test length(Julz.get_all_files("test")) == 0

  Julz.generate("type", "foo")

  @test length(Julz.get_all_files("src")) == 2
  @test length(Julz.get_all_files("test")) == 1

  Julz.destroy("type", "foo")

  @test length(Julz.get_all_files("src")) == 1
  @test length(Julz.get_all_files("test")) == 0

  cd(initial_dir)

  main_file = Julz.get_all_files("dummy/src")[1]

  @test main_file == "dummy/src/JulzDummy.jl"

end

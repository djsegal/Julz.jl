@testset "Get All Files Function Tests" begin

  @test isdefined(Julz, :get_all_files) == true

  initial_dir = pwd()

  cd("dummy")

  @test length(Julz.get_all_files("../dummy")) == 1

  Julz.generate("type", "foo")

  @test length(Julz.get_all_files("../dummy")) == 3

  Julz.destroy("type", "foo")

  @test length(Julz.get_all_files("../dummy")) == 1

  cd(initial_dir)

  main_file = Julz.get_all_files("dummy")[1]

  @test main_file == "dummy/src/JulzDummy.jl"

end

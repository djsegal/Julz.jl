@testset "Get All Files Function Tests" begin

  @test isdefined(Julz, :get_all_files) == true

  cd("dummy") do

    @test length(Julz.get_all_files("src")) == 1
    @test length(Julz.get_all_files("test")) == 0

    Julz.generate("type", "foo")

    @test length(Julz.get_all_files("src")) == 2
    @test length(Julz.get_all_files("test")) == 1

    Julz.destroy("type", "foo")

    @test length(Julz.get_all_files("src")) == 1
    @test length(Julz.get_all_files("test")) == 0

  end

  main_file = Julz.get_all_files("dummy/src")[1]

  @test main_file == "dummy/src/JulzDummy.jl"

end

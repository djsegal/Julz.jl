@testset "Test Function Tests" begin

  @test isdefined(Julz, :test) == true

  initial_dir = pwd()

  dummy_package = "$(Pkg.dir())/JulzDummy"

  cp("dummy", dummy_package, remove_destination=true)

  cd(dummy_package)

  Julz.test()

  cd(initial_dir)

  rm(dummy_package, force=true, recursive=true)

end

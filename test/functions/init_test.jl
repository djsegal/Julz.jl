@testset "Init Function Tests" begin

  @test isdefined(Julz, :init) == true

  initial_dir = pwd()

  cd("tmp")

  package_name = "InitTestPackage"

  rm(package_name, force=true, recursive=true)

  originalSTDERR = STDERR

  (errRead, errWrite) = redirect_stderr()

  PkgDev.generate(package_name, "MIT", path=pwd())

  cd(package_name)

  @test !isdir("src/types")

  Julz.init()

  @test isdir("src/types")

  cd("$initial_dir/tmp")

  rm(package_name, force=true, recursive=true)

  close(errWrite)

  close(errRead)

  redirect_stderr(originalSTDERR)

  cd(initial_dir)

end

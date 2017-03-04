@testset "New Function Tests" begin

  @test isdefined(Julz, :new) == true

  initial_dir = pwd()

  cd("tmp")

  package_name = "TestPackage.jl"

  rm(package_name, force=true, recursive=true)

  originalSTDERR = STDERR

  (errRead, errWrite) = redirect_stderr()

  @test_throws Pkg.PkgError Julz.new(package_name)

  license = "MIT"

  Julz.new(package_name, license)

  close(errWrite)

  close(errRead)

  redirect_stderr(originalSTDERR)

  cd(package_name)

  @test isfile("src/$package_name")

  cd("$initial_dir/tmp")

  rm(package_name, force=true, recursive=true)

  cd(initial_dir)

end

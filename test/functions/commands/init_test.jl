@testset "Init Function Tests" begin

  @test isdefined(Julz, :init) == true

  cd("tmp") do

    package_name = "InitTestPackage"

    rm(package_name, force=true, recursive=true)

    originalSTDERR = STDERR

    (errRead, errWrite) = redirect_stderr()

    PkgDev.generate(package_name, "MIT", path=pwd())

    cd(package_name) do

      @test !isdir("src/types")

      Julz.init()

      @test isdir("src/types")

    end

    rm(package_name, force=true, recursive=true)

    close(errWrite)

    close(errRead)

    redirect_stderr(originalSTDERR)

  end

end

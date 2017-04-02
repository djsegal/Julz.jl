@testset "New Function Tests" begin

  @test isdefined(Julz, :new) == true

  cd("tmp") do

    package_name = "NewTestPackage.jl"

    rm(package_name, force=true, recursive=true)

    originalSTDERR = STDERR

    (errRead, errWrite) = redirect_stderr()

    @test_throws Pkg.PkgError Julz.new(package_name)

    license = "MIT"

    Julz.new(package_name, license)

    close(errWrite)

    close(errRead)

    redirect_stderr(originalSTDERR)

    cd(package_name) do

      @test isfile("src/$package_name")

    end

    rm(package_name, force=true, recursive=true)

  end

end

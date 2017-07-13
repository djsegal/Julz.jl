@testset "Include All Files Function Tests" begin

  @test isdefined(Julz, :include_all_files) == true

  cd("dummy") do

    Julz.generate("function", "baz")

    @test isdefined(:baz) != true

    Julz.include_all_files("$(pwd())/src/functions", is_revised=false)

    @test isdefined(:baz) == true

    Julz.destroy("function", "baz")

  end

end

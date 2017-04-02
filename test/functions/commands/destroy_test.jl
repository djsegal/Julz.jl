@testset "Destroy Function Tests" begin

  @test isdefined(Julz, :destroy) == true

  cd("dummy") do

    file_type = "type"

    file_name = "foo"

    src_file = "src/$(EnglishText.pluralize(file_type))/$file_name.jl"
    test_file = "test/$(EnglishText.pluralize(file_type))/$(file_name)_test.jl"

    rm(src_file, force=true)
    rm(test_file, force=true)

    Julz.generate(file_type, file_name)

    @test isfile(src_file)
    @test isfile(test_file)

    Julz.destroy(file_type, file_name)

    @test !isfile(src_file)
    @test !isfile(test_file)

  end

end

@testset "Title Function Tests" begin

  @test isdefined(Julz, :title) == true

  @test_throws MethodError Julz.title(1)

  @test Julz.title("first") == "First"

  @test Julz.title("first class") == "First Class"

  @test Julz.title("first_class") == "First Class"

  @test Julz.title("first-class") == "First-class"

end

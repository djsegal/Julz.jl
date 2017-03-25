@testset "Get Class Name Function Tests" begin

  @test isdefined(Julz, :get_class_name) == true

  @test_throws MethodError Julz.get_class_name(1)

  @test Julz.get_class_name("first") == "First"

  @test Julz.get_class_name("first class") == "FirstClass"

  @test Julz.get_class_name("first_class") == "FirstClass"

  @test Julz.get_class_name("first-class") == "First-class"

end

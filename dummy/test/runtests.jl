using JulzDummy
using Base.Test

@testset "All Tests" begin
  if ( endswith(pwd(), "/test") ) ; cd("..") ; end

  seed_int = abs(rand(Int16))
  srand(seed_int)
  println("\n Seed: $seed_int \n")

  Julz.include_all_files(
    "$(pwd())/test", is_testing=true,
    reload_function=JulzDummy.load_input
  )

  @test true
end

return

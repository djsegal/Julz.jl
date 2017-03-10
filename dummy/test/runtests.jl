if ( endswith(pwd(), "/test") ) ; cd("..") ; end

using JulzDummy
using Base.Test

@testset "All Tests" begin
  Julz.include_all_files("$(pwd())/test")

  @test true
end

return

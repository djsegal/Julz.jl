using Dummy
using Base.Test

@testset "All Tests" begin
  Julz.include_all_files("$(pwd())/test")
end

return

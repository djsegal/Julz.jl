cd("dummy") do

  Julz.generate("function", "roo")

end

module Woof
  import Julz
  Julz.include_all_files("$(pwd())/dummy/src/functions")
  Julz.@export_all_files "$(pwd())/dummy/src/functions"
end

@testset "Export All Files Macro Tests" begin

  @test isdefined(Julz, Symbol("@export_all_files")) == true

  @test isdefined(Woof, :roo) == true

  cd("dummy") do

    Julz.destroy("function", "roo")

  end

end

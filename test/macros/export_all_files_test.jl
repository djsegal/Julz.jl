initial_dir = pwd()

cd("dummy")

Julz.generate("function", "roo")

module Woof
  import Julz
  Julz.include_all_files("$(pwd())/src/functions")
  Julz.@export_all_files "$(pwd())/src/functions"
end

@testset "Export All Files Macro Tests" begin

  @test isdefined(Julz, Symbol("@export_all_files")) == true

  @test isdefined(Woof, :roo) == true

  Julz.destroy("function", "roo")

  cd(initial_dir)

end

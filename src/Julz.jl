module Julz

  using Mustache
  using EnglishText

  include("functions/get_all_files.jl")
  include("functions/include_all_files.jl")

  src_folder = "$(Pkg.dir())/Julz/src"

  include_all_files(src_folder)
  @export_all_files src_folder

end

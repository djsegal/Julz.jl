module Julz

  using Mustache
  using EnglishText
  using PkgDev

  include("functions/get_all_files.jl")
  include("functions/include_all_files.jl")

  src_folder = dirname(@__FILE__)

  include_all_files(src_folder)
  @export_all_files src_folder

  function main()
    println("done.")
  end

end

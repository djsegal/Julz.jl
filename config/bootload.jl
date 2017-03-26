main_folder = "$(dirname(@__FILE__))/.."

include("$main_folder/src/functions/utils/get_all_files.jl")
include("$main_folder/src/functions/utils/include_all_files.jl")

loaded_folders = [ "src", "config/initializers" ]

for loaded_folder in loaded_folders
  loaded_folder = "$main_folder/$loaded_folder"

  Julz.include_all_files(loaded_folder)
  @eval Julz.@export_all_files $loaded_folder
end

include("$main_folder/input.jl")

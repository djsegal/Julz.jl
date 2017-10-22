main_folder = "$(dirname(@__FILE__))/.."

include("$main_folder/src/functions/utils/get_all_files.jl")
include("$main_folder/src/functions/utils/include_all_files.jl")
include("$main_folder/src/macros/export_all_files.jl")

loaded_folders = [ "config/initializers" , "src" , "lib/tasks" ]

for loaded_folder in loaded_folders
  loaded_folder = "$main_folder/$loaded_folder"

  Julz.include_all_files(loaded_folder, package_name="Julz")
  @eval Julz.@export_all_files $loaded_folder
end

function load_input(raw_input, is_file_input=false, can_be_missing=false)
  if is_file_input
    file_path = "$main_folder/$raw_input"

    if !isfile(file_path)
      file_path = "$main_folder/lib/input_decks/$raw_input"
    end

    if !isfile(file_path)
      if can_be_missing ; return ; end
    end

    open(file_path) do file
      file_lines = map(x -> split(x, "#")[1], readlines(file))
      file_lines = map(x -> strip(x), file_lines)

      raw_input = join(file_lines, ";")

      botched_chars = [ "(" , "," , "[" ]

      for cur_char in botched_chars
        raw_input = replace(raw_input, "$cur_char;", "$cur_char")
      end

      raw_input *= "; nothing ;"
    end
  end

  eval( parse(raw_input) )
end

print_workspace() = Julz.print_workspace({{ app }})

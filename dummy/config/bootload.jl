main_folder = "$(dirname(@__FILE__))/.."

loaded_folders = [ "config/initializers" , "src" , "lib/tasks" ]

for loaded_folder in loaded_folders
  loaded_folder = "$main_folder/$loaded_folder"

  cur_package_name="JulzDummy"
  Julz.include_all_files(loaded_folder, package_name=cur_package_name, is_revised=false)
  @eval Julz.@export_all_files $loaded_folder $cur_package_name
end

function load_input(raw_input, is_file_input=false, can_be_missing=false, is_init_load=false)
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

  old_symbols = get_all_symbols(JulzDummy)
  eval( parse(raw_input) )
  new_symbols = setdiff(get_all_symbols(JulzDummy), old_symbols)

  is_init_load && ( new_symbols = [] )

  for cur_symbol in setdiff(new_symbols, old_symbols)
    cur_expression = quote
      $(cur_symbol) = $(getfield(JulzDummy, cur_symbol))
    end

    eval(Main, cur_expression)
  end
end

print_workspace() = Julz.print_workspace(JulzDummy)

defaults_file_name = "defaults.jl"
load_input(defaults_file_name, true)

scratch_file_name = "tmp/scratch.jl"
Julz.load_input(scratch_file_name, true, true, true)

function destroy(args::Dict)
  file_type = args["<generator>"]
  file_name = args["<name>"]

  destroy(file_type, file_name)
end

function destroy(file_type, file_name)

  if file_type == "init"
    rm("$(pwd())/config/initializers/$file_name.jl")
    return
  end

  if file_type == "task"
    rm("$(pwd())/lib/tasks/$file_name.jl")
    return
  end

  parent_folders = [
    "src",
    "test"
  ]

  for parent_folder in parent_folders
    suffix = ( parent_folder == "test" ) ? "_test" : ""
    file_path = "$(pwd())/$parent_folder/$(pluralize(file_type))/$file_name$suffix.jl"

    if !isfile(file_path) ; continue ; end
    rm(file_path)

    folder_paths = []

    nested_path, parsed_file_name = contains(file_name, "/") ?
      rsplit(file_name, "/"; limit=2) : ("", file_name)

    parsed_file_name = String(parsed_file_name)

    current_nested_path = ""
    for nested_ancestor in split(nested_path, "/")
      current_nested_path = "$current_nested_path/$nested_ancestor"
      folder_path = "$(pwd())/$parent_folder/$(pluralize(file_type))$current_nested_path"

      push!(folder_paths, folder_path)
    end

    reverse!(folder_paths)

    for nested_path in folder_paths
      if length(readdir(nested_path)) != 0
        break
      end
      rm(nested_path)
    end
  end

end

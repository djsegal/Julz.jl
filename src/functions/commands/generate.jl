function generate(args::Dict)
  file_type = args["<generator>"]
  file_name = args["<name>"]
  file_params = args["<field>"]

  generate(file_type, file_name, file_params...)
end

function generate(file_type, file_name, file_params...)

  if file_type == "init"
    touch("$(pwd())/config/initializers/$file_name.jl")
    return
  end

  if file_type == "task"
    file_abs_path = "$(pwd())/lib/tasks/$file_name.jl"

    template_file = generate_file_template("src", "function", file_name, file_params)

    open(file_abs_path, "w") do file
      write(file, template_file)
    end

    return
  end

  parent_folders = [
    "src",
    "test"
  ]

  for parent_folder in parent_folders
    suffix = ( parent_folder == "test" ) ? "_test" : ""
    file_rel_path = "$(pluralize(file_type))/$file_name$suffix.jl"
    file_abs_path = "$(pwd())/$parent_folder/$file_rel_path"

    if isfile(file_abs_path)
      answer = user_input("Do you want to overwrite $file_rel_path? [y/n] ");
      if strip(lowercase(answer)) != "y" ; continue ; end
    end

    nested_path, parsed_file_name = contains(file_name, "/") ?
      rsplit(file_name, "/"; limit=2) : ("", file_name)

    parsed_file_name = String(parsed_file_name)

    current_nested_path = ""
    for nested_ancestor in split(nested_path, "/")
      current_nested_path = "$current_nested_path/$nested_ancestor"
      folder_path = "$(pwd())/$parent_folder/$(pluralize(file_type))$current_nested_path"

      if isdir(folder_path) ; continue ; end
      mkdir(folder_path)
    end

    template_file = generate_file_template(parent_folder, file_type, parsed_file_name, file_params)

    open(file_abs_path, "w") do file
      write(file, template_file)
    end
  end

end

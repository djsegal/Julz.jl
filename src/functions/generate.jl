function generate(file_type, file_name, file_params...)

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

function generate_file_template(parent_folder, file_type, file_name, file_params)
  template_path = "$(dirname(@__FILE__))/../../templates/$parent_folder/$(file_type).jl"

  template = readstring(template_path)

  template_dictionary = Dict()

  template_dictionary["app"] = replace(rsplit(pwd(), "/"; limit=2)[2], ".jl", "")
  template_dictionary["name"] = file_name
  template_dictionary["title"] = title(file_name)
  template_dictionary["class"] = get_class_name(file_name)
  template_dictionary["params"] = join(file_params, ", ")
  template_dictionary["fields"] = join(file_params, "\n  ")

  render(template, template_dictionary)
end

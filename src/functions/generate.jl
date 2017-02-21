function generate(file_type, file_name, file_params...)

  parent_folders = [
    "src",
    "test"
  ]

  for parent_folder in parent_folders
    suffix = ( parent_folder == "test" ) ? "_test" : ""
    file_rel_path = "$(pluralize(file_type))/$file_name$suffix.jl"
    file_abs_path = "$(pwd())/$parent_folder/$file_rel_path"

    template_file = generate_file_template(parent_folder, file_type, file_name, file_params)

    if isfile(file_abs_path)
      answer = user_input("Do you want to overwrite $file_rel_path? [y/n] ");
      if strip(lowercase(answer)) != "y" ; continue ; end
    end

    open(file_abs_path, "w") do file
      write(file, template_file)
    end
  end

end

function generate_file_template(parent_folder, file_type, file_name, file_params)
  template_path = "$(Pkg.dir())/Julz/templates/$parent_folder/$(file_type).jl"

  template = readstring(template_path)

  template_dictionary = Dict()

  template_dictionary["app"] = rsplit(pwd(), "/"; limit=2)[2]
  template_dictionary["name"] = file_name
  template_dictionary["title"] = title(file_name)
  template_dictionary["params"] = join(file_params, ", ")

  render(template, template_dictionary)
end

function generate(file_type, file_name, file_params...)

  parent_folders = [
    "src",
    "test"
  ]

  for parent_folder in parent_folders
    suffix = ( parent_folder == "test" ) ? "_test" : ""
    file_path = "$(pwd())/$parent_folder/$(pluralize(file_type))/$file_name$suffix.jl"

    template_file = generate_file_template(parent_folder, file_type, file_name, file_params)

    open(file_path, "w") do file
      write(file, template_file)
    end
  end

end

function generate_file_template(parent_folder, file_type, file_name, file_params)
  template_path = "$(Pkg.dir())/Julz/templates/$parent_folder/$(file_type).jl"

  template = readstring(template_path)

  template_dictionary = Dict()

  template_dictionary["name"] = file_name
  template_dictionary["params"] = join(file_params, ", ")

  render(template, template_dictionary)
end

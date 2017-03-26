function generate_file_template(parent_folder, file_type, file_name="", file_params=Dict())

  file_suffix = "jl"
  if contains(file_type, ".")
    file_type, file_suffix = map(s -> String(s), split(file_type, "."; limit=2))
  end
  if file_name == "" ; file_name = file_type ; end

  template_path = "$(dirname(@__FILE__))/../../../templates/$parent_folder/$file_type.$file_suffix"

  template = readstring(template_path)

  template_dictionary = Dict()

  template_dictionary["app"] = replace(rsplit(pwd(), "/"; limit=2)[2], ".jl", "")
  template_dictionary["user"] = LibGit2.getconfig("github.user", "")
  template_dictionary["name"] = file_name
  template_dictionary["title"] = title(file_name)
  template_dictionary["class"] = get_class_name(file_name)
  template_dictionary["params"] = join(file_params, ", ")
  template_dictionary["fields"] = join(file_params, "\n  ")

  render(template, template_dictionary)

end

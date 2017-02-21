function init()

  parent_folders = [
    "src",
    "test"
  ]

  folders = [
    "functions",
    "methods",
    "macros",
    "types"
  ]

  for parent_folder in parent_folders
    add_code_to_main_file(parent_folder)

    for folder in folders
      folder_path = "$(pwd())/$parent_folder/$folder"
      if isdir(folder_path) ; continue ; end

      mkdir(folder_path)
      touch("$folder_path/.keep")
    end
  end

end

function add_code_to_main_file(parent_folder)
  package_name = rsplit(pwd(), "/"; limit=2)[2]

  template_dictionary = Dict()

  template_dictionary["src"] = ("package", package_name, "module")
  template_dictionary["test"] = ("runtests", "runtests", "")

  template_name, file_name, buzz_word = template_dictionary[parent_folder]

  template_path = "$(Pkg.dir())/Julz/templates/$parent_folder/$(template_name).jl"
  file_path = "$(pwd())/$parent_folder/$file_name.jl"

  template = readlines(template_path)
  file = readlines(file_path)

  insert_index = length(file)
  if buzz_word != ""
    for (index, file_line) in enumerate(file)
      if !contains(file_line, buzz_word) ; continue ; end
      insert_index = index
      break
    end
  end

  unshift!(template, file[insert_index])
  splice!(file, insert_index, template)

  open(file_path, "w") do old_file
    write(old_file, file)
  end
end

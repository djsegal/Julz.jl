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

  remove_default_test()

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

function remove_default_test()
  test_file_path = "$(pwd())/test/runtests.jl"
  test_file_text = readstring(test_file_path)

  line_1 = "# write your own tests here"
  line_2 = "@test 1 == 2"
  default_test = "\n$line_1\n$line_2\n"

  new_file = replace(test_file_text, default_test, "")
  open(test_file_path, "w") do old_file
    write(old_file, new_file)
  end
end

function add_code_to_main_file(parent_folder)
  package_name = rsplit(pwd(), "/"; limit=2)[2]
  if package_name == "Julz" ; return ; end

  template_dictionary = Dict()

  template_dictionary["src"] = ("package", package_name, "module")
  template_dictionary["test"] = ("runtests", "runtests", "")

  template_name, file_name, buzz_word = template_dictionary[parent_folder]

  template_path = "$(Pkg.dir())/Julz/templates/$parent_folder/$(template_name).jl"
  file_path = "$(pwd())/$parent_folder/$file_name.jl"

  template = readlines(template_path)
  file = readlines(file_path)

  insert_index = length(file)
  for (index, file_line) in enumerate(file)
    if contains(file_line, "Julz") ; return ; end
    if contains(file_line, buzz_word) && buzz_word != ""
      if insert_index == length(file)
        insert_index = index
      end
    end
  end

  unshift!(template, file[insert_index])
  splice!(file, insert_index, template)

  open(file_path, "w") do old_file
    write(old_file, file)
  end
end

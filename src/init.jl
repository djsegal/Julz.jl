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

  for folder in folders
    for parent_folder in parent_folders
      mkdir("$(pwd())/$parent_folder/$folder")
    end
  end

end

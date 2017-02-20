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
      folder_path = "$(pwd())/$parent_folder/$folder"

      mkdir(folder_path)
      touch("$folder_path/.keep")
    end
  end

end

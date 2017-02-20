function destroy(file_type, file_name)

  parent_folders = [
    "src",
    "test"
  ]

  for parent_folder in parent_folders
    suffix = ( parent_folder == "test" ) ? "_test" : ""
    file_path = "$(pwd())/$parent_folder/$(pluralize(file_type))/$file_name$suffix.jl"

    if !isfile(file_path) ; continue ; end
    rm(file_path)
  end

end

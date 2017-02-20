function destroy(file_type, file_name)

  files = [
    "src/$(file_name)",
    "test/$(file_name)_test"
  ]

  map!(file -> "$(pwd())/$(file).jl", files)

  for file in files
    if !isfile(file) ; continue ; end

    rm(file)
  end

end

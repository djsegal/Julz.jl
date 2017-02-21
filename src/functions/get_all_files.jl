function get_all_files(cur_item)
  nested_files = get_nested_files(cur_item)
  clean_files_list(nested_files)

  nested_files
end

function get_nested_files(cur_item)
  nested_files = []

  if isfile(cur_item)
    if endswith(cur_item, ".jl")
      push!(nested_files, cur_item)
    end

    return nested_files
  end

  for sub_item in readdir(cur_item)
    if startswith(sub_item, ".") ; continue ; end

    sub_nested_files = get_nested_files("$cur_item/$sub_item")
    append!(nested_files, sub_nested_files)
  end

  return nested_files
end

function clean_files_list(nested_files)
  delete_list = []

  package_name = rsplit(pwd(), "/"; limit=2)[2]
  push!(delete_list, "$package_name.jl")
  push!(delete_list, "Julz.jl")

  push!(delete_list, "test/runtests.jl")
  push!(delete_list, "src/functions/include_all_files.jl")
  push!(delete_list, "src/functions/get_all_files.jl")

  for deleted_file in delete_list
    for (index, nested_file) in enumerate(nested_files)
      if endswith(nested_file, deleted_file)
        deleteat!(nested_files, index)
        break
      end
    end
  end
end

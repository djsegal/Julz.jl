function include_all_files(cur_item)
  loaded_files = []
  all_files = get_all_files(cur_item)
  unloaded_files = setdiff(all_files, loaded_files)

  while length(unloaded_files) > 0
    new_file_count = 0

    for file in all_files
      is_already_loaded = in(file, loaded_files)
      if is_already_loaded ; continue ; end

      try
        include(file)
      catch
        continue
      end

      push!(loaded_files, file)
      new_file_count += 1
    end

    unloaded_files = setdiff(all_files, loaded_files)

    if new_file_count == 0
      bad_file = unloaded_files[1]
      include(bad_file)
    end
  end
end

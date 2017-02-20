function include_all_files(cur_item)
  all_files = get_all_files(cur_item)

  for file in all_files
    include(file)
  end
end

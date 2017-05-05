function check_for_test_param(cur_item, cur_test_param)

  nested_files = get_nested_files(cur_item)
  clean_files_list(nested_files)

  cur_regex = Regex("$(cur_test_param)\\s*:\\s*true")

  for nested_file in nested_files

    opened_file = open(nested_file)

    for cur_line in eachline(opened_file)
      stripped_line = strip(cur_line)

      if ( stripped_line == "" )
        continue
      end

      if ( !startswith(stripped_line, "#") )
        break
      end

      if ismatch(cur_regex, stripped_line)
        return true
      end
    end

    close(opened_file)

  end

  return false

end

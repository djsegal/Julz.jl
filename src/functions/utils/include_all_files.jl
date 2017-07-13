function include_all_files(cur_item; package_name=nothing, is_testing=false, is_focused=false, is_sorted=false, reload_function=Nullable, is_revised=true)
  loaded_files = []
  all_files = get_all_files(cur_item, package_name=package_name, is_testing=is_testing, is_sorted=is_sorted)
  unloaded_files = setdiff(all_files, loaded_files)

  cur_module = eval(parse("Main.$package_name"))

  while length(unloaded_files) > 0
    new_file_count = 0

    for file in all_files
      is_already_loaded = in(file, loaded_files)
      if is_already_loaded ; continue ; end

      try

        if is_testing

          ignore_file = is_focused && !check_for_focus(file)
          ignore_file |= check_for_skip(file)

          if ignore_file
            push!(loaded_files, file)
            new_file_count += 1
            continue
          end

          if reload_function == Nullable
            error("Need to pass reload_function for tests")
          end

          defaults_file_name = "defaults.jl"
          reload_function(defaults_file_name, true)

          input_file_name = "test/input.jl"
          reload_function(input_file_name, true)

        end

        include(file)

        skip_revise = is_testing || !is_revised
        skip_revise |= contains(file, "config/initializers")
        skip_revise |= contains(file, "src/modules")

        if !skip_revise
          Revise.track(cur_module, file)
        end

      catch
        continue
      end

      push!(loaded_files, file)
      new_file_count += 1
    end

    unloaded_files = setdiff(all_files, loaded_files)

    if new_file_count == 0
      bad_file = unloaded_files[1]
      println(bad_file)
      include(bad_file)
    end
  end
end

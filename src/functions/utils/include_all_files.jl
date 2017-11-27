function include_all_files(cur_item; package_name=nothing, is_testing=false, is_focused=false, is_sorted=false, reload_function=Nullable, is_revised=true)
  loaded_files = []
  all_files = get_all_files(cur_item, package_name=package_name, is_testing=is_testing, is_sorted=is_sorted)
  unloaded_files = setdiff(all_files, loaded_files)

  cur_module = getfield(Main, Symbol(package_name))

  while length(unloaded_files) > 0
    new_file_count = 0

    for file in all_files
      is_already_loaded = in(file, loaded_files)
      if is_already_loaded ; continue ; end

      init_methods_list = filter(
        cur_list -> !isempty(cur_list),
        map(
          cur_var -> try methods(getfield(cur_module, cur_var)) ; catch [] ; end,
          Julz.get_all_symbols(cur_module)
        )
      )

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

        cur_methods_list = filter(
          cur_list -> !isempty(cur_list),
          map(
            cur_var -> try methods(getfield(cur_module, cur_var)) ; catch [] ; end,
            Julz.get_all_symbols(cur_module)
          )
        )

        cur_methods_list = setdiff(cur_methods_list, init_methods_list)

        cur_methods_list = map(
          cur_methods -> filter(
            cur_method -> cur_method.module == cur_module,
            cur_methods.ms
          ),
          cur_methods_list
        )

        cur_methods = flatten(cur_methods_list)

        for cur_method in cur_methods
          delete_method(cur_method)
        end

        Docs.initmeta(cur_module)

        for cur_method in cur_methods
          cur_method_name = cur_method.name

          b = Docs.Binding(cur_module, cur_method_name)
          m = get!(Docs.meta(cur_module), b, Docs.MultiDoc())

          cur_sig_string = string(cur_method.sig)

          cur_sig_string = replace(cur_sig_string, "$(cur_module).#$(cur_method_name)", "")
          cur_sig_string = replace(cur_sig_string, "{,", "{")

          cur_sig = eval(parse(string(cur_sig_string)))

          cur_keys = collect(keys(m.docs))

          for cur_key in cur_keys
            ( cur_sig <: cur_key ) || continue

            delete!(m.docs, cur_key)
          end
        end

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

macro export_all_files(cur_item, package_name)
  all_files = get_all_files(eval(cur_item))

  cur_module = getfield(Main, Symbol(package_name))

  cur_expression = quote end
  for file in all_files
    cur_export = split(file, "/")[end]

    !endswith(cur_export, ".jl") && continue

    cur_export = replace(cur_export, ".jl", "")

    in(cur_export, julia_reserved_words) && continue

    for added_string in ["", "!"]
      cur_export *= added_string
      exported_object = Symbol(cur_export)

      !isdefined(cur_module, exported_object) && continue

      cur_block = quote
        export $(esc(exported_object))
      end

      append!(cur_expression.args, cur_block.args)
    end
  end

  cur_expression
end

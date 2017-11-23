macro export_all_files(cur_item)
  all_files = get_all_files(eval(cur_item))

  cur_expression = quote end
  for file in all_files
    cur_export = split(file, "/")[end]

    !endswith(cur_export, ".jl") && continue

    cur_export = replace(cur_export, ".jl", "")

    exported_object = Symbol(cur_export)

    for added_string in ["", "!"]
      cur_export *= added_string
      exported_object = Symbol(cur_export)

      cur_block = quote
        export $(esc(exported_object))
      end

      append!(cur_expression.args, cur_block.args)
    end
  end

  cur_expression
end

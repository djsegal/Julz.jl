macro export_all_files(cur_item)
  all_files = get_all_files(eval(cur_item))

  cur_expression = quote end
  for file in all_files
    exported_object = Symbol("$(file)")
    cur_block = quote
      export $(esc(exported_object))
    end
    append!(cur_expression.args, cur_block.args)
  end
  cur_expression
end

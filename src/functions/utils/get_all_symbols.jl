"""
    get_all_symbols(cur_module=current_module())

Lorem ipsum dolor sit amet.
"""
function get_all_symbols(cur_module=current_module())
  all_symbols = []

  for n in names(cur_module, true)
    ( !Base.isidentifier(n) ) && continue
    ( in(n, (Symbol(cur_module), :eval)) ) && continue

    push!(all_symbols, n)
  end

  all_symbols
end

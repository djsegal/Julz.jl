"""
    print_workspace(cur_module)

Lorem ipsum dolor sit amet.
"""
function print_workspace(cur_module)

  module_workspace = OrderedDict()

  skip_var_keys = [ Symbol(cur_module) , :doc ]

  skip_start_chars = [ "#" , "/" ]

  skip_julia_types = [ Function , Type , Module ]

  for cur_var in sort(names(cur_module, true))

    skip_var = false

    for cur_skip_key in skip_var_keys
      skip_var |= ( cur_var == cur_skip_key )
    end

    for cur_skip_char in skip_start_chars
      skip_var |= startswith(string(cur_var), cur_skip_char)
    end

    if skip_var ; continue ; end

    cur_value = getfield(cur_module, cur_var)

    for cur_skip_type in skip_julia_types
      skip_var |= isa(cur_value, cur_skip_type)
    end

    if skip_var ; continue ; end

    module_workspace[cur_var] = cur_value

  end

  longest_name = maximum(
    map(
      x -> length(string(x)),
      keys(module_workspace)
    )
  )

  longest_name += 1

  dash_line_length = length(string(cur_module)) + 2

  truncate_length = ( 80 - 5 - longest_name )

  module_header = "\n\n"
  module_header *= "-" ^ dash_line_length
  module_header *= "\n $(cur_module) \n"
  module_header *= "-" ^ dash_line_length
  module_header *= "\n"

  println(module_header)

  for (cur_var, cur_value) in module_workspace
    padded_var = Base.cpad(string(cur_var), longest_name)

    truncated_value = cur_value

    if isa(cur_value, String)
      truncated_value = SubString(
        cur_value, 1, truncate_length
      )
    end

    if truncated_value != cur_value
      truncated_value *= "..."
    end

    println("$padded_var: $truncated_value")
  end

end

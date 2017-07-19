"""
    example_task(cur_input_string="")

Lorem ipsum dolor sit amet.
"""
function example_task(cur_input_string="")
  cur_output_string = "404"

  if cur_input_string != ""
    cur_output_string *= " - $(cur_input_string)"
  end

  println(cur_output_string)
end

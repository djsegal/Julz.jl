function run(args::Dict)

  cur_task = args["<task>"]

  if cur_task == nothing
    cur_task = "main"
  end

  run(cur_task::String)

end

function run(cur_task::String)

  target_name = bump()

  if !isdefined(Symbol(target_name))
    eval(parse("using $target_name"))
  end

  eval(parse("$target_name.$cur_task()"))

end

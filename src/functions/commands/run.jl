function run(args::Dict)

  cur_task = args["<task>"]

  if cur_task == nothing
    cur_task = "main"
  end

  task_params = args["<field>"]

  run(cur_task, task_params)

end

function run(cur_task::String, task_params::AbstractArray=[])

  target_name = bump()

  if !isdefined(Symbol(target_name))
    eval(parse("using $target_name"))
  end

  eval(parse("$target_name.$cur_task($(join(task_params,",")))"))

end

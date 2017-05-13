function run(args::Dict)
  run()
end

function run()

  target_name = bump()

  if !isdefined(Symbol(target_name))
    eval(parse("using $target_name"))
  end

  eval(parse("$target_name.main()"))

end

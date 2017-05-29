function test(args::Dict)
  is_sorted = args["--sorted"]
  is_sorted |= args["-s"]

  test(is_sorted)
end

function test(is_sorted=false)

  open("tmp/scratch.jl", "w") do f
    write(f, "tests_are_sorted = $is_sorted \n")
  end

  target_name = bump()

  Pkg.test(target_name)

end

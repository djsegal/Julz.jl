function test(args::Dict)

  is_sorted = args["--sorted"]
  is_sorted |= args["-s"]

  test(is_sorted)

end

function test(is_sorted=false)

  scratch_file = "$(dirname(@__FILE__))"
  scratch_file *= "/../../../"
  scratch_file *= "tmp/scratch.jl"

  open(scratch_file, "w") do f
    write(f, "tests_are_sorted = $is_sorted \n")
  end

  target_name = bump()

  Pkg.test(target_name)

  open(scratch_file, "w") do f
    write(f, "")
  end

end

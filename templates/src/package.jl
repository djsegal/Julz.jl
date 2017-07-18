
  using Julz

  cd("$(dirname(@__FILE__))/..") do
    include("../config/compile.jl")
  end

  function __init__()
    defaults_file_name = "defaults.jl"
    {{ app }}.load_input(defaults_file_name, true)

    scratch_file_name = "tmp/scratch.jl"
    Julz.load_input(scratch_file_name, true, true)
  end

  function main()
    load_input("input.jl", true)

    println("done.")
  end

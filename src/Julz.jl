module Julz

  using Compat
  using EnglishText
  using Mustache
  using PkgDev
  using Revise

  using Reexport

  export @reexport

  @reexport using DataStructures

  cd("$(dirname(@__FILE__))/..") do
    include("../config/bootload.jl")
  end

  function main()
    load_input("input.jl", true)

    open("output.jl", "w") do cur_file
      write(cur_file, "output = []")
    end

    println("done.")
  end

end

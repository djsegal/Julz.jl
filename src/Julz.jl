module Julz

  using Mustache
  using EnglishText
  using PkgDev
  using DataStructures

  cd("$(dirname(@__FILE__))/..") do
    include("../config/bootload.jl")
  end

  function main()
    load_input("input.jl", true)

    println("done.")
  end

end

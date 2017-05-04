module Julz

  using Mustache
  using EnglishText
  using PkgDev

  if ( endswith(pwd(), "/test") ) ; cd("..") ; end

  if ( endswith(pwd(), "/lib/notebooks") ) ; cd("../..") ; end

  include("../config/bootload.jl")

  function main()
    load_input("input.jl", true)

    println("done.")
  end

end

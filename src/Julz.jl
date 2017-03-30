module Julz

  using Mustache
  using EnglishText
  using PkgDev

  if ( endswith(pwd(), "/test") ) ; cd("..") ; end

  include("../config/bootload.jl")

  function main()
    println("done.")
  end

end

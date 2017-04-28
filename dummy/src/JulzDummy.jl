module JulzDummy

  import Julz

  if ( endswith(pwd(), "/test") ) ; cd("..") ; end

  include("../config/bootload.jl")

  function main()
    load_input("input.jl", true)

    println("done.")
  end

end

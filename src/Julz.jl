module Julz

  using Mustache
  using EnglishText

  export generate
  export destroy
  export init

  include("generate.jl")
  include("destroy.jl")
  include("init.jl")

end

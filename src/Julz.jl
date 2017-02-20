module Julz

  using Mustache
  using EnglishText

  export generate
  export destroy
  export init

  include("functions/generate.jl")
  include("functions/destroy.jl")
  include("functions/init.jl")

end

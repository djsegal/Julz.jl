using Documenter, JulzDummy

makedocs(
  modules = [JulzDummy],
  format = :html,
  sitename = "JulzDummy.jl",
  pages = Any[
    "Home" => "index.md",
  ]
)

deploydocs(
  repo = "github.com/djsegal/JulzDummy.jl.git",
  target = "build",
  deps = nothing,
  make = nothing
)

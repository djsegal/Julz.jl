using Documenter, JulzDummy

makedocs(
  format = :html,
  modules = [ JulzDummy ],
  sitename = "JulzDummy",
  pages = [
  ]
)

deploydocs(
  repo   = "github.com/djsegal/JulzDummy.jl.git",
  target = "build",
  deps   = nothing,
  make   = nothing
)

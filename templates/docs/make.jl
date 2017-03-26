using Documenter, {{ app }}

makedocs(
  format = :html,
  modules = [ {{ app }} ],
  sitename = "{{ app }}",
  pages = [
  ]
)

deploydocs(
  repo   = "github.com/{{ user }}/{{ app }}.jl.git",
  target = "build",
  deps   = nothing,
  make   = nothing
)

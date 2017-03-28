using Documenter, {{ app }}

makedocs(
  format = :html
  sitename = "{{ app }}.jl"
)

deploydocs(
  repo   = "github.com/{{ user }}/{{ app }}.jl.git"
)

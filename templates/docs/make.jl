using Documenter, {{ app }}

makedocs(
  modules = [{{ app }}],
  format = :html,
  sitename = "{{ app }}.jl",
  pages = Any[
    "Home" => "index.md",
    "Code" => "code.md",
    "Glossary" => "glossary.md"
  ]
)

deploydocs(
  repo = "github.com/{{ user }}/{{ app }}.jl.git",
  target = "build",
  deps = nothing,
  make = nothing
)

"""
    install(pkg_name)

Lorem ipsum dolor sit amet.
"""
function install(args::Dict)
  pkg_name = args["<pkg_name>"]

  install(pkg_name)
end

function install(pkg_name)
  Pkg.add(pkg_name)
end

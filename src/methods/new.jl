new(args::Dict) = _new(args::Dict)

function _new(args::Dict)
  pkg_name = args["<pkg_name>"]
  license = args["<license>"]

  new(pkg_name, license)
end

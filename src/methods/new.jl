new(args::Dict) = _new(args::Dict)

function _new(args::Dict)
  app_name = args["<app_path>"]
  license = args["<license>"]

  new(app_name, license)
end

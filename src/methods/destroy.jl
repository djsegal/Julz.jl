destroy(args::Dict) = _destroy(args::Dict)

function _destroy(args::Dict)
  file_type = args["<generator>"]
  file_name = args["<name>"]

  destroy(file_type, file_name)
end

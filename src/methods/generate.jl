generate(args::Dict) = _generate(args::Dict)

function _generate(args::Dict)
  file_type = args["<generator>"]
  file_name = args["<name>"]
  file_params = args["<field>"]

  generate(file_type, file_name, file_params...)
end

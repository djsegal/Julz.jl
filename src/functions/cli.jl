doc = """
julz

Usage:
  julz new <app_path> <license> [options]
  julz init [options]
  julz generate <generator> <name> [<field>...] [options]
  julz destroy <generator> <name> [<field>...] [options]
  julz test [options]
  julz -h | --help
  julz --version
  julz g <generator> <name> [<field>...] [options]
  julz d <generator> <name> [<field>...] [options]
  julz t [options]
  julz hello

Options:
  -f --force                        Overwrite files that already exist
  -h --help                         Show this screen.
  --version                         Show version.
  --path=<path>                     Relative path to use for julia project

Examples:
  julz hello

Help:
  For help using this tool, please open an issue on the Github repository:
  https://github.com/djsegal/julz
"""

using DocOpt  # import docopt function
using Julz

function cli()

  arguments = docopt(doc, version=v"2.0.0")

  aliases = Dict(
    "g" => "generate",
    "d" => "destroy",
    "t" => "test"
  )

  for (key, value) in arguments
    if value != true ; continue ; end

    if haskey(aliases, key)
      key = aliases[key]
    end

    key_symbol = Symbol(key)
    if isdefined(Julz, key_symbol)
      return getfield(Julz, key_symbol)(arguments)
    end
  end

  error("Invalid cli input.")

end

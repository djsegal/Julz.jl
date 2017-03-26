function new(args::Dict)
  pkg_name = args["<pkg_name>"]
  license = args["<license>"]

  if license == "mit" ; license = "MIT" ; end

  new(pkg_name, license)
end

function new(pkg_name, license="null")

  initial_dir = pwd()

  cleaned_pkg_name = get_class_name(pkg_name)
  cleaned_pkg_name = replace(cleaned_pkg_name, ".jl", "")

  PkgDev.generate(cleaned_pkg_name, license, path=initial_dir)

  package_dir = "$initial_dir/$cleaned_pkg_name"

  cd(package_dir)
  init()
  cd(initial_dir)

  mv(package_dir, "$package_dir.jl")

end

function new(pkg_name, license)

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

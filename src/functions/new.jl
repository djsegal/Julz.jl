function new(pkg_name, license)

  cleaned_pkg_name = get_class_name(pkg_name)

  initial_dir = pwd()

  PkgDev.generate(cleaned_pkg_name, license, path=initial_dir)

  package_dir = "$initial_dir/$cleaned_pkg_name"

  cd(package_dir)
  init()
  cd(initial_dir)

end

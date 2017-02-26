function new(app_name, license)

  cleaned_app_name = get_class_name(app_name)

  initial_dir = pwd()

  PkgDev.generate(cleaned_app_name, license, path=initial_dir)

  package_dir = "$initial_dir/$cleaned_app_name"

  cd(package_dir)
  init()
  cd(initial_dir)

end

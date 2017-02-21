function new(app_name, license)

  cleaned_app_name = replace(title(app_name), " ", "")

  PkgDev.generate(cleaned_app_name, license)

  initial_dir = pwd()
  package_dir = "$(Pkg.dir())/$cleaned_app_name"

  cd(package_dir)
  init()
  cd(initial_dir)

end

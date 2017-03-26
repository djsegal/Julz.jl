function docs(args::Dict)
  docs()
end

function docs()

  package_name = rsplit(pwd(), "/"; limit=2)[2]

  package_dir = rsplit(dirname(@__FILE__), "/"; limit=9)[1]

  target_name = replace(package_name, ".jl", "")

  target_path = "$package_dir/$target_name"

  if target_path != pwd()
    initial_dir = pwd()

    cd("..")
    cp(package_name, target_path, remove_destination=true)
    cd(initial_dir)
  end

  include("docs/make.jl")

end

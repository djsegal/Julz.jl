"""
    bump()

Lorem ipsum dolor sit amet.
"""
function bump(args::Dict)
  bump()
end

function bump()

  package_name = rsplit(pwd(), "/"; limit=2)[2]

  package_dir = rsplit(dirname(@__FILE__), "/"; limit=9)[1]

  target_name = replace(package_name, ".jl", "")

  target_path = "$package_dir/$target_name"

  if target_path != pwd()
    cd("..") do
      cp(package_name, target_path, remove_destination=true)
    end
  end

  return target_name

end


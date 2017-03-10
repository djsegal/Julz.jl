function test()
  package_name = rsplit(pwd(), "/"; limit=2)[2]
  Pkg.test(package_name)
end

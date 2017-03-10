test(args::Dict) = _test(args::Dict)

function _test(args::Dict)
  test()
end

test(args::Bool) = dummy_test()

function dummy_test()
  package_name = rsplit(pwd(), "/"; limit=2)[2]
  Pkg.test(package_name)
end

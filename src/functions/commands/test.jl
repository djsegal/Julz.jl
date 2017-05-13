function test(args::Dict)
  test()
end

function test()

  target_name = bump()

  Pkg.test(target_name)

end

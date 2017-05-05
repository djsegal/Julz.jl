import Julz
using Base.Test
using TestSetExtensions

@testset DottedTestSet "All Tests" begin
  if ( endswith(pwd(), "/test") ) ; cd("..") ; end

  seed_int = abs(rand(Int16))
  srand(seed_int)
  println("\n Seed: $seed_int \n")

  test_dir = "$(pwd())/test"

  is_focused = Julz.check_for_focus(test_dir)

  Julz.include_all_files( test_dir,
    is_testing=true, is_focused=is_focused,
    reload_function=Julz.load_input
  )
end

return

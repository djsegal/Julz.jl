@testset "Test Function Tests" begin

  @test isdefined(Julz, :test) == true

  initial_dir = pwd()

  dummy_package = "$(dirname(@__FILE__))/../../../JulzDummy"

  cp("dummy", dummy_package, remove_destination=true)

  cd(dummy_package)

  originalSTDERR = STDERR
  originalSTDOUT = STDOUT

  (errRead, errWrite) = redirect_stderr()
  (outRead, outWrite) = redirect_stdout()

  Julz.test()

  close(errWrite)
  close(outWrite)

  err_data = readavailable(errRead)
  out_data = readavailable(outRead)

  close(errRead)
  close(outRead)

  redirect_stderr(originalSTDERR)
  redirect_stdout(originalSTDOUT)

  cd(initial_dir)

  rm(dummy_package, force=true, recursive=true)

  @test contains(String(err_data), "INFO: JulzDummy tests passed")

end

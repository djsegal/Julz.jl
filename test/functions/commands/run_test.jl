@testset "Run Function Tests" begin

  @test isdefined(Julz, :run) == true

  originalSTDOUT = STDOUT

  (outRead, outWrite) = redirect_stdout()

  Julz.run()

  close(outWrite)

  data = readavailable(outRead)

  close(outRead)

  redirect_stdout(originalSTDOUT)

  @test String(data) == "done.\n"

end

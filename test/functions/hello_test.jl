@testset "Hello Function Tests" begin

  @test isdefined(Julz, :hello) == true

  originalSTDOUT = STDOUT

  (outRead, outWrite) = redirect_stdout()

  Julz.hello()

  close(outWrite)

  data = readavailable(outRead)

  close(outRead)

  redirect_stdout(originalSTDOUT)

  @test String(data) == "Hello, World!\n"

end

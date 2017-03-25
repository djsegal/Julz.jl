@testset "Cli Function Tests" begin

  @test isdefined(Julz, :cli) == true

  originalSTDOUT = STDOUT

  (outRead, outWrite) = redirect_stdout()

  run(`$JULIA_HOME/julia -L $(dirname(@__FILE__))/../../../../Julz/src/functions/utils/cli.jl -e 'cli()' -- hello`)

  close(outWrite)

  data = readavailable(outRead)

  close(outRead)

  redirect_stdout(originalSTDOUT)

  @test String(data) == "Hello, World!\n"

end

@testset "Run Function Tests" begin

  @test isdefined(Julz, :run) == true

  run_examples = Dict(
    "main" => "done.\n",
    "example_task" => "404\n"
  )

  for (cur_task, cur_output) in run_examples

    originalSTDOUT = STDOUT

    (outRead, outWrite) = redirect_stdout()

    Julz.run(cur_task)

    close(outWrite)

    data = readavailable(outRead)

    close(outRead)

    redirect_stdout(originalSTDOUT)

    @test String(data) == cur_output

  end

end

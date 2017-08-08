@testset "Run Function Tests" begin

  @test isdefined(Julz, :run) == true

  run_examples = Dict(
    "main" => "done.\n",
    "example_task" => "404\n"
  )

  output_file_name = "output.jl"

  for (cur_task, cur_output) in run_examples

    if isfile(output_file_name) ; rm(output_file_name) ; end

    originalSTDOUT = STDOUT

    (outRead, outWrite) = redirect_stdout()

    Julz.run(cur_task)

    close(outWrite)

    data = readavailable(outRead)

    close(outRead)

    redirect_stdout(originalSTDOUT)

    @test String(data) == cur_output

    if cur_task == "main"
      @test isfile(output_file_name)
    end

  end

  test_input = ["\"woof\""]
  test_output = "404 - woof\n"

  originalSTDOUT = STDOUT

  (outRead, outWrite) = redirect_stdout()

  Julz.run("example_task", test_input)

  close(outWrite)

  data = readavailable(outRead)

  close(outRead)

  redirect_stdout(originalSTDOUT)

  @test String(data) == test_output

end

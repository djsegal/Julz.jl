@testset "User Input Function Tests" begin

  @test isdefined(Julz, :user_input) == true

  filename = tempname()
  open(filename, "w") do f
    println(f, "yes")
  end

  originalSTDOUT = STDOUT

  (outRead, outWrite) = redirect_stdout()

  answer = open(filename) do f
    redirect_stdin(f) do
      Julz.user_input("Yes or no? ")
    end
  end

  close(outWrite)

  close(outRead)

  redirect_stdout(originalSTDOUT)

  rm(filename)
  @test contains(answer, "yes")
  @test !contains(answer, "no")

end

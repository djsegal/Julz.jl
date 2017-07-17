"""
    console()

Lorem ipsum dolor sit amet.
"""
function console(args::Dict)
  console()
end

function console()

  target_name = bump()

  Base.run(`julia -ie "using $(target_name)"`)

end

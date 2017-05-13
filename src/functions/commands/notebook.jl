"""
    notebook()

Lorem ipsum dolor sit amet.
"""
function notebook(args::Dict)
  notebook()
end

function notebook()

  target_name = bump()

  Base.run(`jupyter notebook --notebook-dir=./lib/notebooks`)

end


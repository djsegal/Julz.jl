"""
    notebook()

Lorem ipsum dolor sit amet.
"""
function notebook(args::Dict)
  notebook()
end

function notebook()
  Base.run(`jupyter notebook --notebook-dir=./lib/notebooks`)
end

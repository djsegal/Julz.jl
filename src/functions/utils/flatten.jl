"""
    flatten(a::AbstractArray)

Lorem ipsum dolor sit amet.
"""
function flatten(a::AbstractArray)
  while any(x->typeof(x)<:AbstractArray, a)
    a = collect(Iterators.flatten(a))
  end

  return a
end

function title(s::AbstractString)
  join([ucfirst(w) for w in split(replace(s, "_", " "))], " ")::typeof(s)
end

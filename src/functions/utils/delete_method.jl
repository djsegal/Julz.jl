### Core functionality for method deletion
using Core: MethodInstance
using Base: MethodList

const themethod = Ref{Any}(nothing)

function delete_method(m::Method)
    # While methods(getfield(m.module, m.name)) works in many cases, it fails when
    # a nonex-ported function is extended by a different module.
    # Invalidate the cache of the callers
    try
    invalidate_callers(m.specializations)
    # Remove from method list
    mt = get_methodtable(m.sig)
    ml = MethodList(mt)
    drop_from_tme!(mt, :defs, m)
    # Delete compiled instances of this method from the cache
    drop_from_tme!(mt, :cache, m)
    # Delete this signature
    deleteat!(ml.ms, findfirst(x->x==m, ml.ms))
    catch err
        themethod[] = m
        showerror(STDERR, err)
        rethrow(err)
    end
nothing
end

delete_method(::Void) = nothing

get_methodtable(u::UnionAll) = get_methodtable(u.body)
get_methodtable(sig) = _get_methodtable(sig.parameters[1])
_get_methodtable(u::UnionAll) = (@show u; _get_methodtable(u.body))
_get_methodtable(f) = f.name.mt

invalidate_callers(::Void) = nothing

function invalidate_callers(tml::TypeMapLevel)
    global themethod
    println("here")
    themethod[] = tml
    nothing
end

function invalidate_callers(tme::TypeMapEntry)
    while isa(tme, TypeMapEntry)
        invalidate_callers(tme.func)
        tme = tme.next
    end
    nothing
end

function invalidate_callers(mi::MethodInstance, iddict=ObjectIdDict())
    iddict[mi] = true
    if isdefined(mi, :backedges)
        for c in mi.backedges
            haskey(iddict, c) && continue
            invalidate_callers(c, iddict)
        end
    end
    mtc = get_methodtable(mi.def.sig)
    drop_from_tme!(mtc, :cache, mi)
    drop_from_tme!(mi.def, :specializations, mi)
end

function drop_from_tme!(mt::Union{MethodTable,Method}, fn::Symbol, m::Union{Method,MethodInstance})
    nodeprev, node = nothing, getfield(mt, fn)
    while isa(node, TypeMapEntry)
        if node.func === m
            if nodeprev == nothing
                setfield!(mt, fn, node.next)
            else
                nodeprev.next = node.next
            end
        end
        nodeprev, node = node, node.next
    end
    mt
end

### Parsing expressions to determine which method to delete
const ExLike = Union{Expr,Revise.RelocatableExpr}
# Much is taken from ExpressionUtils.jl but generalized to work with ExLike

function get_signature(ex::E) where E <: ExLike
    while ex.head == :macrocall && isa(ex.args[end], E) || is_trivial_block_wrapper(ex)
        ex = ex.args[end]::E
    end
    if ex.head == :function
        return ex.args[1]
    elseif ex.head == :(=) && isa(ex.args[1], E)
        ex = ex.args[1]::E
        if ex.head == :where || ex.head == :call
            return ex
        end
    end
    nothing
end

function get_method(mod::Module, sig::ExLike)
    t = split_sig(mod, convert(Expr, sig))
    mths = Base._methods_by_ftype(t, -1, typemax(UInt))
    if !isempty(mths)
        # There might be many methods, but the one that should match should be the
        # last one, since methods are ordered by specificity
        return mths[end][3]
    end
    warn("Revise failed to find any methods for signature ", t, "\n  Most likely it was already deleted.")
    nothing
end

function split_sig(mod::Module, ex::Expr)
    t = split_sig_expr(mod, ex)
    return eval(mod, t) # fex), eval(mod, argex)
end

function split_sig_expr(mod::Module, ex::Expr, wheres...)
    if ex.head == :where
        return split_sig_expr(mod, ex.args[1], ex.args[2:end], wheres...)
    end
    fex = ex.args[1]
    sigex = Expr(:curly, :Tuple, :(typeof($fex)), argtypeexpr.(ex.args[2:end])...)
    for w in wheres
        sigex = Expr(:where, sigex, w...)
    end
    sigex
end

function is_trivial_block_wrapper(ex::ExLike)
    if ex.head == :block
        return length(ex.args) == 1 ||
            (length(ex.args) == 2 && (is_linenumber(ex.args[1]) || ex.args[1]===nothing))
    end
    false
end
is_trivial_block_wrapper(Compat.@nospecialize arg) = false

function is_linenumber(Compat.@nospecialize stmt)
    (isa(stmt, ExLike) && (stmt).head == :line) || isa(stmt, LineNumberNode)
end

argtypeexpr(s::Symbol) = :Any
function argtypeexpr(ex::ExLike)
    if ex.head == :...
        return :(Vararg{$(argtypeexpr(ex.args[1]))})
    end
    if ex.head != :(::)
        @show ex.head ex.args
    end
    ex.head == :(::) || throw(ArgumentError("expected :(::) expression, got ex.head = $(ex.head)"))
    1 <= length(ex.args) <= 2 || throw(ArgumentError("expected 1 or 2 args, got $(ex.args)"))
    ex.args[end]
end

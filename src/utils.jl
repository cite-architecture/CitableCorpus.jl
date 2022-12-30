"""Select `CitablePassage`s identified by a `CtsUrn`
from a corpus.  Returns a (possibly empty) Vector
of `CitablePassage`s.
$(SIGNATURES)
"""
function select(u::CtsUrn, c::CitableTextCorpus)
    indices = indexurn(u, c)
    if isempty(indices)
        CitablePassage[]
    elseif length(indices) == 1
        [c.passages[indices[1]]]
    else
        c.passages[indices[1]:indices[2]]
    end
end

"""Select `CitablePassage`s identified by a `CtsUrn`
from a source vector `v`.
$(SIGNATURES)
"""
function select(u::CtsUrn, v::Vector{CitablePassage})
    select(u, CitableTextCorpus(v))
end

"""Find index of two URNs `u1` and `u2` in corpus `c`.
$(SIGNATURES)
"""
function indexrange(u1::CtsUrn, u2::CtsUrn, c::CitableTextCorpus)
    startrange = filter(p -> p.urn == u1, c.passages)
    endrange = filter(p -> p.urn == u2, c.passages)
    if isempty(startrange) || isempty(endrange)
        @warn("Invalid range reference.")
        []
    else
        urnstrings = map(p -> string(p.urn), c.passages)
        idx1 = findall(s -> s == string(startrange[1].urn), urnstrings)
        if length(idx1) != 1
            @error("No node found for $(u1)")
        end
        idx2 = findall(s -> s == string(endrange[1].urn), urnstrings)
        if length(idx2) != 1
            @error("No node found for $(u2)")
        end
        (idx1[1], idx2[1])
    end
end



"""Find index of URN `u` in corpus `c`.
$(SIGNATURES)
"""
function indexnode(u::CtsUrn, c::CitableTextCorpus)
    if isrange(u)
        u1 = addpassage(u, range_begin(u))
        u2 = addpassage(u, range_end(u))
        indexrange(u1, u2, c)

    else
        psgs = filter(psg -> urncontains(u, psg.urn), c.passages)
        if isempty(psgs)
            []

        elseif length(psgs) > 1  # container
            indexrange(psgs[1].urn,psgs[end].urn,c)
            

        else # leaf node
            urnstrings = map(psg -> string(psg.urn), c)
            findall(s -> s == string(u), urnstrings)
            
        end
    end
end


"""Find index of URN `u` in corpus `c`.
$(SIGNATURES)
"""
function indexurn(u::CtsUrn, c::CitableTextCorpus)
    if isrange(u)
        #=
        opener = range_begin(u)
        closer = range_end(u)
        u1 = addpassage(u, opener)
        u2  = addpassage(u, closer)
        indexrange(u1, u2, c)
        =#
        indexnode(u,c)
    else
        indexnode(u, c)       
    end
end


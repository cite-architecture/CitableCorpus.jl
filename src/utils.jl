"""Select `CitablePassage`s identified by a `CtsUrn`
from a corpus.
$(SIGNATURES)
"""
function select(u::CtsUrn, c::CitableTextCorpus)
    if isrange(u)
        selectrange(u, c)
        
    else
        selectnode(u, c)
    end
end


"""Select `CitablePassage`s identified by a `CtsUrn`
from a vector of `CitablePassage`s.
$(SIGNATURES)
"""
function select(u::CtsUrn, doc::CitableDocument)
    select(u, CitableTextCorpus(doc.passages))
end

"""Select `CitablePassage`s identified by a `CtsUrn`
from a vector of `CitablePassage`s.
$(SIGNATURES)
"""
function select(u::CtsUrn, v::Vector{CitablePassage})
    select(u, CitableTextCorpus(v))
end


"""Select `CitablePassage`s identified by a `CtsUrn` referring to a single node from a corpus.
$(SIGNATURES)
"""
function selectnode(u::CtsUrn, c::CitableTextCorpus)
    if isrange(u)
        selectrange(u, c)
    else
        psgs = filter(psg -> urncontains(u, psg.urn), c.passages)
        if isempty(psgs)
            []

        elseif length(psgs) > 1
            rangepsg = passagecomponent(psgs[1].urn) * "-" * passagecomponent(psgs[end].urn)
            selectrange(addpassage(u, rangepsg), c)

        else
            psgs
        end
    end
end





"""Select `CitablePassage`s identified by a `CtsUrn` referring to a single node from a corpus.
$(SIGNATURES)
"""
function selectrange(range::CtsUrn, c::CitableTextCorpus) 
    if !isrange(range)
        selectnode(range)
    else
        opener = range_begin(range)
        closer = range_end(range)
        u1 = addpassage(range, opener)
        u2  = addpassage(range, closer)
        selectrange(u1, u2, c)
    end
end


"""Select `CitablePassage`s identified by a `CtsUrn` referring to a range from a corpus.
$(SIGNATURES)
"""
function selectrange(u1::CtsUrn, u2::CtsUrn, c::CitableTextCorpus)
    # get indexes for u1, u2. slice c.passages from idx1:idx2
    # but 
    # ====> could be range from container to container! <=======
    # NEED TO CHECK FOR THIS
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
        c.passages[idx1[1]:idx2[1]]
    end
end
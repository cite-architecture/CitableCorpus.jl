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

function selectrange(u1::CtsUrn, u2::CtsUrn, c::CitableTextCorpus)
    # get indexes for u1, u2. slice c.passages from idx1:idx2
    # but could be range from container to container!
    



    urnstrings = map(p -> string(p.urn), c.passages)
    idx1 = findall(s -> s == string(u1), urnstrings)
    if length(idx1) != 1
        @error("No node found for $(u1)")
    end
    idx2 = findall(s -> s == string(u2), urnstrings)
    if length(idx2) != 1
        @error("No node found for $(u2)")
    end
    c.passages[idx1[1]:idx2[1]]
end
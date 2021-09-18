
"""Retrieve citable passages identified by `u` from a corpus.
Returns a (possibly empty) Vector of `CitablePassage`s.
$(SIGNATURES)
"""
function retrieve(u::CtsUrn, c::CitableTextCorpus)
    df = c.passages |> DataFrame
    retrieve(u, df)
end

"""Retrieve citable passages identified by `u` from a document.
Returns a (possibly empty) Vector of `CitablePassage`s.
$(SIGNATURES)
"""
function retrieve(u::CtsUrn, doc::CitableDocument)
    df = doc.passages |> DataFrame
    retrieve(u, df)
end

"""Retrieve citable passages identified by `u` from a DataFrame of 
citable passages.
Returns a (possibly empty) Vector of `CitablePassage`s.

$(SIGNATURES)
"""
function retrieve(u::CtsUrn, psgdf::DataFrame)
    isrange(u) ? retrieve_range(u, psgdf) : retrieve_simple(u, psgdf)
end

"""Find citable passages in `psgdf` contained by `u`.

$(SIGNATURES)
"""
function retrieve_simple(u::CtsUrn, psgdf::DataFrame)
    psgs = []
    for r in eachrow(psgdf)
        if urncontains(u, r.urn)
            push!(psgs, CitablePassage(r.urn, r.text))
        end
    end
    psgs
end


"""Find citable passages in `psgdf` contained by `u`.

$(SIGNATURES)
"""
function retrieve_range(u::CtsUrn, psgdf::DataFrame)
    urn1 = addpassage(u, range_begin(u))
    indices1 = row_indices(urn1, psgdf)



    urn2 = addpassage(u, range_end(u))
    indices2 = row_indices(urn2, psgdf)
    
    if isempty(indices1) || isempty(indices2)
        []
    else
        psgs = []
        startidx = indices1[1]
        endidx = indices2[end]
        range = psgdf[startidx:endidx, :]
        for r in eachrow(range)
            push!(psgs, CitablePassage(r.urn, r.text))
        end
        psgs
    end
end


"""Find row indices in `psgdf` for passages contained by `u`.

$(SIGNATURES)
"""
function row_indices(u::CtsUrn, psgdf::DataFrame)
    indices = []
    for r in eachrow(psgdf)
        if urncontains(u, r.urn)
            push!(indices, rownumber(r))
        end
    end
    indices
end
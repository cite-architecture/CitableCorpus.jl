
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
    @warn("Not yet implemetned")
    nothing
end

function retrieve_simple(u::CtsUrn, psgdf::DataFrame)
    @warn("Not yet implemetned")
    nothing
end

function retrieve_range(u::CtsUrn, psgdf::DataFrame)
    @warn("Not yet implemetned")
    nothing
end

function row_indices(u::CtsUrn, psgdf::DataFrame)
    @warn("Not yet implemetned")
    nothing
end
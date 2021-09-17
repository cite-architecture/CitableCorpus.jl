

function retrieve(c::CitableTextCorpus, u::CtsUrn)
    df = c.passages |> DataFrame
    retrieve(df, u)
end

function retrieve(doc::CitableDocument, u::CtsUrn)
    df = doc.passages |> DataFrame
    retrieve(df, u)
end

function retrieve(psgdf::DataFrame, u::CtsUrn)
    @warn("Not yet implemetned")
    nothing
end
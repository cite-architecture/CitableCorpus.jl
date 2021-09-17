
"""Find the next `CitablePassage` after `u` in a corpus.
If no passage found, or `u` is last passage in corpus, return `nothing`.
$(SIGNATURES)
"""
function next(c::CitableTextCorpus, u::CtsUrn)
    df = c.passages |> DataFrame
    next(df, u)
end


"""Find the next `CitablePassage` after `u` in a document.
If no passage found, or `u` is last passage in document, return `nothing`.
$(SIGNATURES)
"""
function next(doc::CitableDocument, u::CtsUrn)
    df = doc.passages |> DataFrame
    next(df, u)
end


"""Find the next `CitablePassage` after `u` in a DataFrame.
If no passage found, or `u` is last passage in DataFrame, return `nothing`.
$(SIGNATURES)
"""
function next(psgdf::DataFrame, u::CtsUrn)
    nextpsg = nothing
    for r in eachrow(psgdf)
        if urncontains(u, r.urn)
            rownum = rownumber(r)
            if  rownum < nrow(psgdf)
                nextpsg = CitablePassage(
                    psgdf[rownum + 1, :urn],
                    psgdf[rownum + 1, :text],
                )
            end
        end
        
    end
    nextpsg
end



"""Find the previous `CitablePassage` before `u` in a corpus.
If no passage found, or `u` is the first passage in the corpus, return `nothing`.
$(SIGNATURES)
"""
function prev(c::CitableTextCorpus, u::CtsUrn)
    df = c.passages |> DataFrame
    prev(df, u)
end



"""Find the previous `CitablePassage` before `u` in a document.
If no passage found, or `u` is the first passage in the document, return `nothing`.
$(SIGNATURES)
"""
function prev(doc::CitableDocument, u::CtsUrn)
    df = doc.passages |> DataFrame
    prev(df, u)
end



"""Find the previous `CitablePassage` before `u` in a DataFrame.
If no passage found, or `u` is the first passage in the DataFrame, return `nothing`.
$(SIGNATURES)
"""
function prev(psgdf::DataFrame, u::CtsUrn)
    prevpsg = nothing
    for r in eachrow(psgdf)
        if urncontains(u, r.urn)
            rownum = rownumber(r)
            if  rownum > 1
                prevpsg = CitablePassage(
                    psgdf[rownum  - 1, :urn],
                    psgdf[rownum - 1, :text],
                )
            end
        end
        
    end
    prevpsg
end



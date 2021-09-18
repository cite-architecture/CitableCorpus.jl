
"""Find the next `CitablePassage` after `u` in a corpus.
If no passage found, or `u` is last passage in corpus, return `nothing`.
$(SIGNATURES)
"""
function next(u::CtsUrn, c::CitableTextCorpus)
    df = c.passages |> DataFrame
    next(u, df)
end


"""Find the next `CitablePassage` after `u` in a document.
If no passage found, or `u` is last passage in document, return `nothing`.
$(SIGNATURES)
"""
function next(u::CtsUrn, doc::CitableDocument)
    df = doc.passages |> DataFrame
    next(u, df)
end


"""Find the next `CitablePassage` after `u` in a DataFrame.
If no passage found, or `u` is last passage in DataFrame, return `nothing`.
$(SIGNATURES)
"""
function next(u::CtsUrn, psgdf::DataFrame)
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
function prev(u::CtsUrn, c::CitableTextCorpus)
    df = c.passages |> DataFrame
    prev(u, df)
end



"""Find the previous `CitablePassage` before `u` in a document.
If no passage found, or `u` is the first passage in the document, return `nothing`.
$(SIGNATURES)
"""
function prev(u::CtsUrn, doc::CitableDocument)
    df = doc.passages |> DataFrame
    prev(u, df)
end



"""Find the previous `CitablePassage` before `u` in a DataFrame.
If no passage found, or `u` is the first passage in the DataFrame, return `nothing`.
$(SIGNATURES)
"""
function prev(u::CtsUrn, psgdf::DataFrame)
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



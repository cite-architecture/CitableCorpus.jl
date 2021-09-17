"A canonically citable text corpus."
struct CitableTextCorpus
    passages
end

"""
$(SIGNATURES)
Create a DataFrame from a `CitableTextCorpus`
"""
function textdf(c::CitableTextCorpus)
    c.passages |> DataFrame
end

"""
$(SIGNATURES)
Create a single composite CitableTextCorpus` from two sources.
"""
function combine(c1::CitableTextCorpus, c2::CitableTextCorpus)
    CitableTextCorpus(vcat(c1.corpus, c2.corpus))
end


"""
$(SIGNATURES)
Create a single composite CitableTextCorpus` from an array of source corpora by recursively adding corpora.
"""
function combine(src_array, composite = nothing)
    if src_array === nothing || length(src_array) == 0
        composite
    else 
        trim = src_array[1]
        popfirst!(src_array) 
        if composite === nothing
            combine(src_array, trim)
        else
            newcomposite = combine(trim, composite)
            combine(src_array, newcomposite)
        end
    end
end


"""Compose a delimited-text string for a corpus.

$(SIGNATURES)
"""
function cex(c::CitableTextCorpus, delimiter="|")
    # Rm newlines from output.
    txt = map( cn -> string(
            cn.urn.urn, delimiter, 
            replace(cn.text, "\n" => " ")), 
            c.passage)
    join(txt, "\n") * "\n"
end


"""Read content of `ctsdata` blocks in CEX-formatted string into 
a `CitableTextCorpus`.

$(SIGNATURES)
"""
function corpus_fromcex(cexstring, delimiter = "|")
    allblocks = blocks(cexstring)
    ctsblocks = blocksfortype("ctsdata", allblocks)
    passages = []
    for blk in ctsblocks
        for psg in blk.lines
            push!(passages, passage_fromcex(psg, delimiter))
        end
    end
    CitableTextCorpus(passages)
end

function documents(c::CitableTextCorpus)
    @warn("Not yet implemetned")
    nothing
end

function document_urns(c::CitableTextCorpus)
    @warn("Not yet implemetned")
    nothing
end

function document(c::CitableTextCorpus, u::CtsUrn)
    @warn("Not yet implemetned")
    nothing
end

function next(c::CitableTextCorpus, u::CtsUrn)
    df = c.passages |> DataFrame
    next(df, u)
end

function next(doc::CitableDocument, u::CtsUrn)
    df = doc.passages |> DataFrame
    next(df, u)
end

function next(psgdf::DataFrame, u::CtsUrn)
    nextpsg = nothing
    for r in eachrow(psgdf)
        #println(rownumber(r))
        if urncontains(u, r.urn)
            rownum = rownumber(r)
            println("at ", rownumber(r))
            if  rownum < nrow(psgdf)
                nextpsg = psgdf[rownum + 1, :]
            end
        end
        
    end
    nextpsg
end

function prev(c::CitableTextCorpus, u::CtsUrn)
    df = c.passages |> DataFrame
    prev(df, u)
end

function prev(doc::CitableDocument, u::CtsUrn)
    df = doc.passages |> DataFrame
    prev(df, u)
end

function prev(psgdf::DataFrame, u::CtsUrn)
    @warn("Not yet implemetned")
    nothing
end






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

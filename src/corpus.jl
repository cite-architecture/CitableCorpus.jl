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
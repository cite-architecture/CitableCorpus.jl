"A canonically citable text corpus."
struct CitableTextCorpus
    passages
end

CitableLibraryTrait(::Type{CitableTextCorpus}) = CitableLibraryCollection()

"""Looks up text passage with URN `u` in corpus `c`.
Returns either a single `CitableTextPassage` or `nothing`.

$(SIGNATURES)
"""
function urnequals(u::CtsUrn, c::CitableTextCorpus, )
    matches = filter(psg -> psg.urn == u, c.passages)
    isempty(matches) ? nothing : matches[1]
end

"""Looks up passage in corpus `c` with URNs contained by `u`. Returns either a (possible empty) Vector of `CitableTextPassage`s.

$(SIGNATURES)
"""
function urncontains(u::CtsUrn, c::CitableTextCorpus)
    filter(psg -> urncontains(u, psg.urn), c.passages)
end


"""Serializes `c` to CEX format.

$(SIGNATURES)
"""
function cex(c::CitableTextCorpus; delimiter="|")
    lines = ["#!ctsdata"]
    for p in c.passages
        push!(lines, cex(p, delimiter = delimiter))
    end
    join(lines,"\n")
end
#=
"""Compose a delimited-text string for a corpus.

$(SIGNATURES)
"""
function cex(c::CitableTextCorpus)
    # Rm newlines from output.
    txt = map( cn -> string(
            cn.urn.urn, delimiter, 
            replace(cn.text, "\n" => " ")), 
            c.passages)
    "#!ctsdata\n" * join(txt, "\n") * "\n"
end
=#

"""Required function to iterate a document using julia `Base` functions.

$(SIGNATURES)
"""
function iterate(c::CitableTextCorpus)
    isempty(c.passages) ? nothing : (c.passages[1], 1)
end

"""Required function to iterate a document using julia `Base` functions.

$(SIGNATURES)
"""
function iterate(c::CitableTextCorpus, state)
    next = state + 1
    next > length(c.passages) ? nothing : (c.passages[next], next)
end


"""Override Base.== for `CitableTextCorpus`.
    $(SIGNATURES)
"""        
function ==(corp1::CitableTextCorpus, corp2::CitableTextCorpus)
    if length(corp1.passages) == length(corp2.passages)
        all(corp1.passages .== corp2.passages)
    else
        false
    end
end

"""Override Base.print for `CitableTextCorpus`.
$(SIGNATURES)
"""
function print(io::IO, corp::CitableTextCorpus)
    doccount = document_urns(corp.passages) |> length
    psgcount = corp.passages |> length
    msg = "Corpus with $psgcount citable passages in $doccount documents."
    print(io,msg)
end

"""Override Base.show for `CitableDocument`.
$(SIGNATURES)
"""
function show(io::IO, corp::CitableTextCorpus)
    doccount = document_urns(corp.passages) |> length
    psgcount = corp.passages |> length
    msg = "Corpus with $psgcount citable passages in $doccount documents."
    print(io,msg)
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
    CitableTextCorpus(vcat(c1.passages, c2.passages))
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



"""Parse a Vector of `CiteEXchange.Blocks` into 
a `CitableTextCorpus`.

$(SIGNATURES)
"""
function fromblocks(v::CiteEXchange.Block[]; delimiter = "|" ) #Vector{CiteEXchange.Block}, CitableTextCorpus; delimiter = "|")
    ctsblocks = blocksfortype("ctsdata", v)
    @info("CTS BLOCKS", ctsblocks)
    passages = []
    for blk in ctsblocks
        for psg in blk.lines
            push!(passages, fromcex(psg, CitablePassage; delimiter = delimiter))
        end
    end
    CitableTextCorpus(passages)
end

"""Read content of `ctsdata` blocks in CEX-formatted string into 
a `CitableTextCorpus`.

$(SIGNATURES)
"""
function fromcex(cexstring::AbstractString, CitableTextCorpus; delimiter = "|")
    allblocks = blocks(cexstring)
    @info("Now make corpus from CEX blocks", allblocks)
    if isempty(allblocks)
        throw(DomainError(cexstring, "No #!ctsdata blocks found."))
    end
    @info(typeof(allblocks))
    fromblocks(allblocks; delimiter = delimiter)
end


"""Read content of `ctsdata` blocks in CEX-formatted source into a `CitableTextCorpus`.

$(SIGNATURES)
"""
function fromcex(bytevector::AbstractVector{UInt8}, CitableTextCorpus; delimiter = "|")
    fromcex(String(bytevector), CitableTextCorpus ;delimiter = delimiter)
end

"""Create a Vector of citable documents in a corpus.

$(SIGNATURES)
"""
function documents(corp::CitableTextCorpus)
   docs = []
   for docurn in document_urns(corp)
        push!(docs, document(docurn, corp))
   end
   docs
end

"""Identify documents in a list of passages by URN.

$(SIGNATURES)
"""
function document_urns(psglist)
    map(p -> droppassage(p.urn), psglist) |> unique
 end


"""Identify documents in a corpus by URN.

$(SIGNATURES)
"""
function document_urns(c::CitableTextCorpus)
    map(p -> droppassage(p.urn), c.passages) |> unique
end


"""Extract a citable document from a corpus.  
If no matching document found, return nothing.

$(SIGNATURES)
"""
function document(u::CtsUrn, c::CitableTextCorpus)
    psgs = filter(p -> urncontains(u, p.urn), c.passages)
    isempty(psgs) ? nothing  :     CitableDocument(u, "Citable document", psgs)
end

"""Count passages in corpus.

$(SIGNATURES)
"""
function passage_count(c::CitableTextCorpus)
    length(c.passages)
end
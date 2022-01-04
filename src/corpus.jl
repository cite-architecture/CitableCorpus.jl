"A canonically citable text corpus."
struct CitableTextCorpus
    passages::Vector{CitablePassage}
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

"""Override Base.== for `CitableTextCorpus`.
    $(SIGNATURES)
"""        
function ==(corp1::CitableTextCorpus, corp2::CitableTextCorpus)
    corp1.passages == corp2.passages
end

"""Identify documents in a corpus by URN.

$(SIGNATURES)
"""
function document_urns(c::CitableTextCorpus)
    map(p -> droppassage(p.urn), c.passages) |> unique
end

"""Identify documents in a list of passages by URN.

$(SIGNATURES)
"""
function document_urns(v::Vector{CitablePassage})
    map(p -> droppassage(p.urn), v) |> unique
end


"Singleton type to use as value for CitableTrait"
struct CitableCorpusTrait <: CitableCollectionTrait end
"""Define`CitableTrait` value for `CitableTextCorpus`.
$(SIGNATURES)
"""
function citablecollectiontrait(::Type{CitableTextCorpus})
    CitableCorpusTrait()
end

"Singleton type to use as value for UrnComparisonTrait"
struct CtsComparableCorpus <: UrnComparisonTrait end
"""Define`CitableTrait` value for `TextCatalogCollection`.
$(SIGNATURES)
"""
function urncomparisontrait(::Type{CitableTextCorpus})
    CtsComparableCorpus()
end

"""Filter `corpus` for entries with urn matching `urn` for equality.
$(SIGNATURES)
"""
function urnequals(urn::CtsUrn, corpus::CitableTextCorpus)
    filter(item -> urnequals(item.urn, urn), corpus.passages)
end

"""Filter `corpus` for entries with urn matching `urn` for containment.
$(SIGNATURES)
"""
function urncontains(urn::CtsUrn, corpus::CitableTextCorpus)
    filter(item -> urncontains(urn, item.urn), corpus.passages)
end

"""Filter `corpus` for entries with urn matching `urn` for similarity.
$(SIGNATURES)
"""
function urnsimilar(urn::CtsUrn, corpus::CitableTextCorpus)
    filter(item -> urnsimilar(item.urn, urn), corpus.passages)
end

"Singleton type to use as value for CexTrait"
struct CexCorpus <: CexTrait end
"""Define`CexTrait` value for `CitableTextCorpus`.
$(SIGNATURES)
"""
function cextrait(::Type{CitableTextCorpus})
    CexCorpus()
end

"""Serialize `c` to CEX format.

$(SIGNATURES)
"""
function cex(c::CitableTextCorpus; delimiter="|")
    lines = ["#!ctsdata"]
    for p in c.passages
        push!(lines, cex(p, delimiter = delimiter))
    end
    join(lines,"\n")
end

"""Read content of `ctsdata` blocks in CEX-formatted string into 
a `CitableTextCorpus`.

$(SIGNATURES)
"""
function fromcex(cexstring::AbstractString,  ::Type{CitableTextCorpus}; 
    delimiter = "|", configuration = nothing)
    ctsdata = data(cexstring, "ctsdata")
    passages = []
    for ln in ctsdata
        push!(passages, fromcex(ln, CitablePassage; delimiter = delimiter))
    end
    isempty(passages) ? nothing : CitableTextCorpus(passages)
end

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


"""Implement `length` for `CitableTextCorpus`.
$(SIGNATURES)
"""
function length(c::CitableTextCorpus)
    length(c.passages)
end

"""Implement `eltype` for `TextCatalogCollection`.
$(SIGNATURES)
"""
function eltype(c::CitableTextCorpus)
    CitablePassage
end


## OLD TO REVIW 
#=
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





"""Extract a citable document from a corpus.  
If no matching document found, return nothing.

$(SIGNATURES)
"""
function document(u::CtsUrn, c::CitableTextCorpus)
    psgs = filter(p -> urncontains(u, p.urn), c.passages)
    isempty(psgs) ? nothing  :     CitableDocument(u, "Citable document", psgs)
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


"""Read content of `ctsdata` blocks in CEX-formatted source into a `CitableTextCorpus`.

$(SIGNATURES)
"""
function fromcex(bytevector::AbstractVector{UInt8}, CitableTextCorpus; delimiter = "|")
    fromcex(String(bytevector), CitableTextCorpus ;delimiter = delimiter)
end




"""Parse a Vector of `CiteEXchange.Blocks` into 
a `CitableTextCorpus`.

$(SIGNATURES)
"""
function fromblocks(v::Vector{CiteEXchange.Block}; delimiter = "|" ) #Vector{CiteEXchange.Block}, CitableTextCorpus; delimiter = "|")
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
=#

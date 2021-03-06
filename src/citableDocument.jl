"A canonically citable text."
struct CitableDocument <: Citable
    urn::CtsUrn
    title::AbstractString
    passages
end


"""Override Base.== for `CitablePassage`.
$(SIGNATURES)
"""        
function ==(doc1::CitableDocument, doc2::CitableDocument)
    if length(doc1.passages) == length(doc2.passages)
        all(doc1.passages .== doc2.passages)
    else
        false
    end
end


"""Override Base.show for `CitableDocument`.
$(SIGNATURES)
"""
function show(io::IO, doc::CitableDocument)
    count = doc.passages |> length
    suffix = count == 1 ? "" : "s"
    str = string(label(doc), " <", urn(doc), "> $count citable passage$suffix" )
    show(io,str)
end


function text(doc::CitableDocument)
    map(psg -> psg.text, doc.passages)
end


"Value for CitableTrait"
struct DocumentCitableByCtsUrn <: CitableTrait end

"""Define`CitableTrait` value for `CitablePassage`.
$(SIGNATURES)
"""
function citabletrait(::Type{CitableDocument})
    DocumentCitableByCtsUrn()
end

"""URN identifyiing `doc`.
$(SIGNATURES)
Required function for `Citable` abstraction.
"""
function urn(doc::CitableDocument)
    doc.urn
end

"""Label for `doc`.
$(SIGNATURES)
Required function for `Citable` abstraction.
"""
function label(doc::CitableDocument)
    doc.title
end




struct CtsUrnComparableDocument <: UrnComparisonTrait end





struct CexDocument <: CexTrait end

"""Define`CexTrait` value for `CitablePassage`.
$(SIGNATURES)
"""
function cextrait(::Type{CitableDocument})
    CexDocument()
end

"""Format a `CitableDocument` as a CEX `ctsdata` block.
$(SIGNATURES)
Required function for `Citable` abstraction.
"""
function cex(doc::CitableDocument; delimiter = "|")
    notabene = join(["// ", label(doc), ", ", urn(doc)])
    sz = join(["// ", length(doc.passages), " citable passages."])
    lines = ["#!ctsdata",notabene, sz, "//"]
    for psg in doc.passages
        push!(lines, cex(psg; delimiter = delimiter))
    end
    join(lines,"\n")
end

"""Parse a Vector `CiteEXchange.Block`s into a `CitableDocument`.
$(SIGNATURES)
"""
function fromcex(v::Vector{CiteEXchange.Block}, CitableDocument; delimiter = "|", docurn = nothing, title = nothing)
    label = isnothing(title) ? "Unlabelled citable document" : title

    ctsblocks = blocksfortype("ctsdata", v)
    passages = []
    for blk in ctsblocks
        for psg in blk.lines
            push!(passages, fromcex(psg, CitablePassage; delimiter = delimiter))
        end
    end
    if isnothing(docurn)
        topurn = passages[1].urn |> droppassage
        # check that all passages are in same doc.
        docurns = document_urns(passages)
        if length(docurns) != 1
            throw(DomainError("Found $(length(docurns)) documents in source data."))
        end
        CitableDocument(topurn, label, passages)
    else
        docpassages = filter(p -> urncontains(docurn, p.urn), passages)
        if isempty(docpassages)
            throw(ArgumentError("No passages in input matched urn $docurn"))
        else
            CitableDocument(docurn, label, docpassages)
        end
    end
end

"""Parse a CEX `ctsdata` block into a `CitableDocument`.
$(SIGNATURES)
"""
#function fromcex(cexstring, CitableDocument; delimiter = "|", docurn = nothing, title = nothing)
function fromcex(cexstring, CitableDocument; delimiter = "|", configuration = nothing)
    allblocks = blocks(cexstring)
    #fromcex(allblocks, CitableDocument; delimiter = delimiter, docurn = docurn, title = title)
    nothing
end


"""Create a DataFrame of passages in `doc`.
$(SIGNATURES)
"""
function textdf(doc::CitableDocument)
    doc.passages |> DataFrame
end


"Singleton value for CitableCollectionTrait"
struct CitableDocumentCollection <: CitableCollectionTrait end

"""Define`CitableCollectionTrait` value for `CitableDocument`.
$(SIGNATURES)
"""
function citablecollectiontrait(::Type{CitableDocument})
    CitableDocumentCollection()
end





# implement full set of iterate with 
# length, eltype

"""Required function to iterate a document using julia `Base` functions.

$(SIGNATURES)
"""
function iterate(doc::CitableDocument)
    isempty(doc.passages) ? nothing : (doc.passages[1], 1)
end

"""Required function to iterate a document using julia `Base` functions.

$(SIGNATURES)
"""
function iterate(doc::CitableDocument, state)
    next = state + 1
    next > length(doc.passages) ? nothing : (doc.passages[next], next)
end

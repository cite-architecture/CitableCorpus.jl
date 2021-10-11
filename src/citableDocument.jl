"A canonically citable text."
struct CitableDocument <: Citable
    urn::CtsUrn
    title::AbstractString
    passages
end

CitableTrait(::Type{CitableDocument}) = CitableByCtsUrn()


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

"""Format a `CitableDocument` as a CEX `ctsdata` block.
$(SIGNATURES)
"""
function cex(doc::CitableDocument, delim = "|")
    notabene = join(["// ", label(doc), ", ", urn(doc)])
    sz = join(["// ", length(doc.passages), " citable passages."])
    lines = ["#!ctsdata",notabene, sz, "//"]
    for psg in doc.passages
        push!(lines, cex(psg))
    end
    join(lines,"\n")
end

"""Parse a CEX `ctsdata` block into a `CitableDocument`.
$(SIGNATURES)
"""
function document_fromcex(cexstring, delimiter = "|"; docurn = nothing, title = nothing)
    label = isnothing(title) ? "Citable document" : title
    allblocks = blocks(cexstring)
    ctsblocks = blocksfortype("ctsdata", allblocks)
    passages = []
    for blk in ctsblocks
        for psg in blk.lines
            push!(passages, passage_fromcex(psg, delimiter))
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

"""Override Base.print for `CitableDocument`.
$(SIGNATURES)
"""
function print(io::IO, doc::CitableDocument)
    count = doc.passages |> length
    suffix = count == 1 ? "" : "s"
    print(io, label(doc), " <", urn(doc), "> $count citable passage$suffix" )
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


"""Create a DataFrame of passages in `doc`.
$(SIGNATURES)
"""
function textdf(doc::CitableDocument)
    doc.passages |> DataFrame
end
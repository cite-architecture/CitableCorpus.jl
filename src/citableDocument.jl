"A canonically citable text."
struct CitableDocument <: Citable
    urn::CtsUrn
    title::AbstractString
    passages
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
    nb = join(["// ", label(doc), ", ", urn(doc)])
    sz = join(["// ", length(doc.passages), " citable passages."])
    lines = ["#!ctsdata",nb, sz, "//"]
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
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
function document_fromcex(block, delimiter = "|")

    
end
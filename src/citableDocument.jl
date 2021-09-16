"A canonically citable text."
struct CitableDocument <: Citable
    urn::CtsUrn
    label::AbstractString
    passages
end


function urn(doc::CitableDocument)
    doc.urn
end


function label(doc::CitableDocument)
    doc.label
end

function cex(doc::CitableDocument, delim = "|")
    nb = join(["// ", label(doc), ", ", urn(doc)])
    sz = join(["// ", length(doc.passages), " citable passages."])
    lines = ["#!ctsdata",nb, sz, "//"]
    for psg in doc.passages
        push!(lines, cex(psg))
    end
    join(lines,"\n")
end


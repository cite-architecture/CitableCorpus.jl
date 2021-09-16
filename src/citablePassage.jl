"A canonically citable text node."
struct CitablePassage <: Citable
    urn::CtsUrn
    text::AbstractString
end

function urn(psg::CitablePassage)
    psg.urn
end


function label(psg::CitablePassage)
    psg.text
end


function cex(psg::CitablePassage, delim = "|")
    join([psg.urn, psg.text], delim)
end


function print(io::IO, psg::CitablePassage)
    print(io, "<", psg.urn, "> ", psg.text)
end
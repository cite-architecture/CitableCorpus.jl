"A canonically citable text node."
struct CitablePassage <: Citable
    urn::CtsUrn
    text::AbstractString
end

"""Override Base.== for `CitablePassage`.
$(SIGNATURES)
"""        
function ==(psg1::CitablePassage, psg2::CitablePassage)
    psg1.urn == psg2.urn && psg1.text == psg2.text
end

"""URN identifyiing `psg`.
$(SIGNATURES)
Required function for `Citable` abstraction.
"""
function urn(psg::CitablePassage)
    psg.urn
end


"""Label for `psg`.
$(SIGNATURES)
Required function for `Citable` abstraction.
"""
function label(psg::CitablePassage)
    psg.text
end


"""Format a `CitablePassage` as a delimited-text string.
$(SIGNATURES)
Required function for `Citable` abstraction.
"""
function cex(psg::CitablePassage, delim = "|")
    join([psg.urn, psg.text], delim)
end


"""Override Base.print for `CitablePassage`.
$(SIGNATURES)
Required function for `Citable` abstraction.
"""
function print(io::IO, psg::CitablePassage)
    print(io, "<", psg.urn, "> ", psg.text)
end


"""Parse a delimited-text string into a `CitablePassage`.
$(SIGNATURES)
"""
function passage_fromcex(s::AbstractString, delimiter = "|")
    parts = split(s, delimiter)
    if length(parts) == 2 
        u = CtsUrn(parts[1])
        CitablePassage(u, parts[2])
    else 
        throw(DomainError(s, "Invalid input. Found $(length(parts)) columns delimited by $delimiter"))
    end
end
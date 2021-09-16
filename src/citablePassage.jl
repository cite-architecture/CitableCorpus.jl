"A canonically citable text node."
struct CitablePassage <: Citable
    urn::CtsUrn
    text::AbstractString
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
    length(parts) == 2 ? "Yoohoo" : throw(DomainError(s, "Did not find two columns delimited by $delimiter"))

    #CitablePassage(CtsUrn(parts[1]), parts[2])
end
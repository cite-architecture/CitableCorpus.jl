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

"""Override Base.show for `CitablePassage`.
$(SIGNATURES)
Required function for `Citable` abstraction.
"""
function show(io::IO, psg::CitablePassage)
    print(io, "<", psg.urn, "> ", psg.text)
end




"Value for CitableTrait"
struct PassageCitableByCtsUrn <: CitableTrait end

"""Define`CitableTrait` value for `CitablePassage`.
$(SIGNATURES)
"""
function citabletrait(::Type{CitablePassage})  
    PassageCitableByCtsUrn()
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
    string(psg)
end

"""Text content of `psg`.
$(SIGNATURES)
"""
function text(psg::CitablePassage)
    psg.text
end

"Value for CexTrait"
struct CexPassage <: CexTrait end
"""Define`CexTrait` value for `CitablePassage`.
$(SIGNATURES)
"""
function cextrait(::Type{CitablePassage})  
    CexPassage()
end
"""Format a `CitablePassage` as a delimited-text string.
$(SIGNATURES)
Required function for `Citable` abstraction.
"""
function cex(psg::CitablePassage; delimiter = "|")
    join([psg.urn, psg.text], delimiter)
end

"""Parse a delimited-text string into a `CitablePassage`.
$(SIGNATURES)
"""
function fromcex(s::AbstractString, ::Type{CitablePassage}; delimiter = "|", configuration = nothing)
    parts = split(s, delimiter)
    if length(parts) == 2 
        u = CtsUrn(parts[1])
        CitablePassage(u, parts[2])
    else 
        throw(DomainError(s, "Invalid input. Found $(length(parts)) columns delimited by $delimiter"))
    end
end

"Value for UrnComparisonTrait"
struct CtsUrnComparablePassage <: UrnComparisonTrait end

"""Define`UrnComparisonTrait` value for `CitablePassage`.
$(SIGNATURES)
"""
function urncomparisontrait(::Type{CitablePassage})
    CtsUrnComparablePassage()
end

"""True if urn matches psg.urn for equality.
$(SIGNATURES)
"""
function urnequals(psg::CitablePassage, urn)
    urnequals(urn, psg.urn)
end


"""True if urn matches psg.urn for containment.
$(SIGNATURES)
"""
function urncontains(psg::CitablePassage, urn)
    urncontains(urn, psg.urn)
end



"""True if urn matches psg.urn for similarity.
$(SIGNATURES)
"""
function urnsimilar(psg::CitablePassage, urn)
    urnsimilar(urn, psg.urn)
end

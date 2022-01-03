"A catalog of texts."
struct TextCatalogCollection
    entries::Vector{CatalogedText}
end


"""Override Base.show for `TextCatalogCollection`.
$(SIGNATURES)
"""
function show(io::IO, catalog::TextCatalogCollection)
    print(io, "TextCatalogCollection with ", length(catalog.entries), " entries")
end


"Singleton type to use as value for CitableTrait"
struct CitableTextCatalog <: CitableCollectionTrait end

"""Define`CitableTrait` value for `TextCatalogCollection`.
$(SIGNATURES)
"""
function citablecollectiontrait(::Type{TextCatalogCollection})
    CitableTextCatalog()
end



"Singleton type to use as value for UrnComparisonTrait"
struct CtsComparableTextCatalog <: UrnComparisonTrait end

"""Define`CitableTrait` value for `TextCatalogCollection`.
$(SIGNATURES)
"""
function citablecollectiontrait(::Type{TextCatalogCollection})
    CtsComparableTextCatalog()
end

"""Filter `catalog` for entries with urn matching `urn` for equality.
$(SIGNATURES)
"""
function urnequals(urn::CtsUrn, catalog::TextCatalogCollection )
    filter(item -> urnequals(item.urn, urn), catalog.entries)
end


"""Filter `catalog` for entries with urn matching `urn` for containment.
$(SIGNATURES)
"""
function urncontains(urn::CtsUrn, catalog::TextCatalogCollection)
    filter(item -> urncontains(urn, item.urn), catalog.entries)
end


"""Filter `catalog` for entries with urn matching `urn` for similarity.
$(SIGNATURES)
"""
function urnsimilar(urn::CtsUrn, catalog::TextCatalogCollection)
    filter(item -> urnsimilar(item.urn, urn), catalog.entries)
end





"Singleton type to use as value for CexTrait"
struct TextCatalogCex <: CexTrait end

"""Define`CexTrait` value for `TextCatalogCollection`.
$(SIGNATURES)
"""
function cextrait(::Type{TextCatalogCollection})
    TextCatalogCex()
end
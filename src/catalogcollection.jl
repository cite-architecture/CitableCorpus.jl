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


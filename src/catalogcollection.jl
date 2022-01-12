"A catalog of texts."
struct TextCatalogCollection
    entries::Vector{CatalogedText}
end

"""Override Base.== for `TextCatalogCollection`.
$(SIGNATURES)
"""
function ==(cat1::TextCatalogCollection, cat2::TextCatalogCollection)
    cat1.entries == cat2.entries
end


"""Override Base.show for `TextCatalogCollection`.
$(SIGNATURES)
"""
function show(io::IO, catalog::TextCatalogCollection)
    print(io, "TextCatalogCollection with ", length(catalog.entries), " entries")
end



# Implement Tables.jl interface
"""Define `CitableTextCorpus` as implementing `Tables`.
$(SIGNATURES)
"""
function istable(cat::TextCatalogCollection)
    true
end

"""Implement `rows` function for `TextCatalogCollection`.
$(SIGNATURES)
"""
function rows(cat::TextCatalogCollection)
    Tables.rows(cat.entries)
end

"""Implement `columns` function for `CitableTextCorpus`.
$(SIGNATURES)
"""
function columns(cat::TextCatalogCollection)
    Tables.columns(cat.entries)
end





"Singleton type to use as value for CitableTrait"
struct CitableTextCatalog <: CitableCollectionTrait end

"""Define`CitableTrait` value for `TextCatalogCollection`.
$(SIGNATURES)
"""
function citablecollectiontrait(::Type{TextCatalogCollection})
    CitableTextCatalog()
end

"""Identify URN type for a `TextCatalogCollection` as `CtsUrn`.
$(SIGNATURES)
"""
function urntype(catalog::TextCatalogCollection)
    CtsUrn
end

"Singleton type to use as value for UrnComparisonTrait"
struct CtsComparableTextCatalog <: UrnComparisonTrait end

"""Define`UrnComparisonTrait` value for `TextCatalogCollection`.
$(SIGNATURES)
"""
function urncomparisontrait(::Type{TextCatalogCollection})
    CtsComparableTextCatalog()
end

"""Filter `catalog` for entries with urn matching `urn` for equality.
$(SIGNATURES)
"""
function urnequals(urn::CtsUrn, catalog::TextCatalogCollection )
    filter(item -> urnequals(item.urn, urn), catalog.entries) |> TextCatalogCollection
end


"""Filter `catalog` for entries with urn matching `urn` for containment.
$(SIGNATURES)
"""
function urncontains(urn::CtsUrn, catalog::TextCatalogCollection)
    filter(item -> urncontains(urn, item.urn), catalog.entries) |> TextCatalogCollection
end


"""Filter `catalog` for entries with urn matching `urn` for similarity.
$(SIGNATURES)
"""
function urnsimilar(urn::CtsUrn, catalog::TextCatalogCollection)
    filter(item -> urnsimilar(item.urn, urn), catalog.entries) |> TextCatalogCollection
end



"Singleton type to use as value for CexTrait"
struct TextCatalogCex <: CexTrait end

"""Define`CexTrait` value for `TextCatalogCollection`.
$(SIGNATURES)
"""
function cextrait(::Type{TextCatalogCollection})
    TextCatalogCex()
end

"""Serialize `catalog` to a `ctscatalog` block.
$(SIGNATURES)
"""
function cex(catalog::TextCatalogCollection; delimiter = "|")
    lines = ["#!ctscatalog",
    join(["urn","citationScheme","groupName","workTitle","versionLabel","exemplarLabel","online","language"], delimiter)
    ]
    for entry in catalog.entries
        push!(lines, cex(entry))
    end
    join(lines, "\n")
end

"""Instantiate a text catalog from CEX source
$(SIGNATURES)
"""
function fromcex(trait::TextCatalogCex, cexsrc::AbstractString, ::Type{TextCatalogCollection}; 
    delimiter = "|", configuration = nothing, strict = true)
    catalogdata = data(cexsrc, "ctscatalog", delimiter = delimiter)
    entries = []
    for dataline in catalogdata
        push!(entries, fromcex(dataline, CatalogedText, delimiter = delimiter))
    end
    isempty(entries) ? nothing : TextCatalogCollection(entries)
end


# Iteration:

"""Implement required iterate function with one parameter for `TextCatalogCollection`.
$(SIGNATURES)
"""
function iterate(catalog::TextCatalogCollection)
    isempty(catalog.entries) ? nothing : (catalog.entries[1], 2)
end

"""Implement required iterate function with two parameters for `TextCatalogCollection`.
$(SIGNATURES)
"""
function iterate(catalog::TextCatalogCollection, state)
    state > length(catalog.entries) ? nothing : (catalog.entries[state], state + 1)
end


"""Implement `length` for `TextCatalogCollection`.
$(SIGNATURES)
"""
function length(catalog::TextCatalogCollection)
    length(catalog.entries)
end

"""Implement `eltype` for `TextCatalogCollection`.
$(SIGNATURES)
"""
function eltype(catalog::TextCatalogCollection)
    CatalogedText
end


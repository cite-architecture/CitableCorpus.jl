"A catalog description of a text."
struct CatalogedText <: Citable
    urn::CtsUrn
    citation
    group
    work
    version
    exemplar
    online::Bool
    lang
end

"""Construct a `CatalogedText` allowing for some default values.
$(SIGNATURES)
"""
function entry(u::CtsUrn, citation, group, work, version; exemplar = nothing, online = true, lang = "eng")
    CatalogedText(u,citation, group, work, version,  exemplar, online, lang)
end


"""Override Base.== for `CatalogedText`.
$(SIGNATURES)
Required function for `Citable` abstraction.
"""
function ==(t1::CatalogedText, t2::CatalogedText)
    t1.urn == t2.urn && t1.citation == t2.citation && t1.group == t2.group && t1.work == t2.work && t1.version == t2.version && t1.exemplar == t2.exemplar && t1.online == t2.online && t1.lang == t2.lang
end


"""Override Base.show for `CatalogedText`.
$(SIGNATURES)
Required function for `Citable` abstraction.
"""
function show(io::IO, catentry::CatalogedText)
    print(io, "<", catentry.urn, "> ", catentry.group, ", ", catentry.work, ", ", catentry.version)
end


"""Retrieve label for citation pattern of `txt`.
$(SIGNATURES)
"""
function citation(txt::CatalogedText)
    txt.citation
end

"""Calculate number of citation levels defined for a cataloged text.
$(SIGNATURES)
"""
function citationdepth(catalogedtext::CatalogedText; subdivider = ",")
    length(split(catalogedtext.citation,subdivider))
end


""""Find in a dataframe of catalog data the number of citation levels defined for a text identified by URN.

$(SIGNATURES)
"""    
function citationdepth(u::CtsUrn, df)
    matched = filter(row -> row.urn == u, df)
    citation = matched[1,:citation]
    length(split(citation,","))
end

"""Retrieve label for text group of `txt`.
$(SIGNATURES)
"""
function textgroup(txt::CatalogedText)
    txt.group
end

"""Retrieve label for work of `txt`.
$(SIGNATURES)
"""
function work(txt::CatalogedText)
    txt.work
end

"""Retrieve label for version of `txt`.
$(SIGNATURES)
"""
function version(txt::CatalogedText)
    txt.version
end

"""Retrieve label for exemplar (if any) of `txt`.
$(SIGNATURES)
"""
function exemplar(txt::CatalogedText)
    txt.exemplar
end


"""True if `txt` is online.
$(SIGNATURES)
"""
function online(txt::CatalogedText)
    txt.online
end

"""Retrieve ISO language code for `txt`.
$(SIGNATURES)
"""
function lang(txt::CatalogedText)
    txt.lang
end




"Singleton type to use as value for CitableTrait"
struct CitableTextEntry <: CitableTrait end

"""Define`CitableTrait` value for `CatalogedText`.
$(SIGNATURES)
"""
function citabletrait(::Type{CatalogedText}) 
    CitableTextEntry()
end

"""Find URN identifier for a `CatalogedText`.
$(SIGNATURES)
"""
function urn(catentry::CatalogedText)
    catentry.urn
end


"""Find human-readable label for a `CatalogedText`.
$(SIGNATURES)
"""
function label(catentry::CatalogedText)
    string(catentry)
end


"""Identify URN type for a `CatalogedText` as `CtsUrn`.
$(SIGNATURES)
"""
function urntype(catentry::CatalogedText)
    CtsUrn
end


"Singleton type to use as value for UrnComparisonTrait"
struct CtsComparableTextCatalogEntry <: UrnComparisonTrait end
"""Define`UrnComparisonTrait` value for `CatalogedText`.
$(SIGNATURES)
"""
function urncomparisontrait(::Type{CatalogedText}) 
    CtsComparableTextCatalogEntry()
end



"""True if urn matches catentry.urn for equality.
$(SIGNATURES)
"""
function urnequals(catentry::CatalogedText, urn)
    urnequals(urn, catentry.urn)
end


"""True if urn matches catentry.urn for containment.
$(SIGNATURES)
"""
function urncontains(catentry::CatalogedText, urn)
    urncontains(urn, catentry.urn)
end

"""True if urn matches catentry.urn for similarity.
$(SIGNATURES)
"""
function urnsimilar(catentry::CatalogedText, urn)
    urnsimilar(urn, catentry.urn)
end



"Value for CexTrait"
struct CexCatalogedText <: CexTrait end
"""Define`CexTrait` value for `CatalogedText`.
$(SIGNATURES)
"""
function cextrait(catentry::CatalogedText)
    CexCatalogedText()
end

"""Implement `cex` function required by `Citable` interface 
for `CatalogedText`.
$(SIGNATURES)
"""
function cex(cataloged::CatalogedText; delimiter = "|")
    join([cataloged.urn.urn, cataloged.citation, cataloged.group, cataloged.work, cataloged.version, cataloged.exemplar, cataloged.online, cataloged.lang], delimiter)
end



"""Parse a single line of CEX data into a `CatalogedText`.
$(SIGNATURES)
"""
function fromcex(cexstring::AbstractString,  ::Type{CatalogedText}; delimiter = "|", configuration = nothing, strict = true)
    boolstrings = ["t", "true", "y", "yes"]
    pieces = split(cexstring, delimiter)
    urn = CtsUrn(pieces[1])
    citation = pieces[2]
    textgroup = pieces[3]
    textwork = pieces[4]
    textversion = pieces[5]
    textexemplar = isempty(pieces[6]) || pieces[6] == "nothing" ? nothing : pieces[6]
    onlineval = lowercase(pieces[7]) in boolstrings
    lang = pieces[8]
    CatalogedText(urn, citation, textgroup,
    textwork, textversion, textexemplar, 
    onlineval, lang)
end

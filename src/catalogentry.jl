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
    txt.exemplar
end

"""Retrieve ISO language code for `txt`.
$(SIGNATURES)
"""
function lang(txt::CatalogedText)
    txt.lang
end






"Single type to use as value for UrnComparisonTrait"
struct CitableTextEntry <: CitableTrait end

"""Define`UrnComparisonTrait` value for `CatalogedText`.
$(SIGNATURES)
"""
function citabletrait(::Type{CatalogedText}) 
    CitableTextEntry()
end

function urn(catentry::CatalogedText)
    catentry.urn
end

function label(catentry::CatalogedText)
    string(catentry)
end


"Value for UrnComparisonTrait"
struct CtsComparableTextCatalogEntry <: UrnComparisonTrait end

"Value for CexTrait"
struct CexCatalogedText <: CexTrait end




#=

"""Implement `urn` function required by `Citable` interface 
for `CatalogedText`.
$(SIGNATURES)
"""
function urn(cataloged::CatalogedText)
    cataloged.urn
end


"""Implement `label` function required by `Citable` interface 
for `CatalogedText`.
$(SIGNATURES)
"""
function label(cataloged::CatalogedText)
    isnothing(cataloged.version) ? string(cataloged.group, ", ", cataloged.work) : string(cataloged.group, ", ", cataloged.work, ", (", cataloged.version, ")")
end

"""Override Base.print for `CatalogedText`.
$(SIGNATURES)
"""
function print(io::IO, doc::CatalogedText)
    print(io, " <", urn(doc), "> ", label(doc) )
end

"""Override Base.show for `CatalogedText`.
$(SIGNATURES)
"""
function show(io::IO, doc::CatalogedText)
    str = string("<", urn(doc), "> ", label(doc))
    show(io,str)
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
function catalogedtext(cexstring; delimiter = "|") 
    boolstrings = ["t", "true"]
    pieces = split(cexstring, delimiter)
    urn = CtsUrn(pieces[1])
    citation = pieces[2]
    textgroup = pieces[3]
    textwork = pieces[4]
    textversion = pieces[5]
    textexemplar = pieces[6]
    onlineval = lowercase(pieces[7]) in boolstrings
    lang = pieces[8]
    CatalogedText(urn, citation, textgroup,
    textwork, textversion, textexemplar, 
    onlineval, lang)
end

function catalogdf_fromcex(blocks::Vector{CiteEXchange.Block}; delimiter = "|")
    @info("Reading Blocks")
    catblocks = blocksfortype("ctscatalog", blocks)
    textcatalog = []
    for blk in catblocks
        for ln in blk.lines[2:end]
            push!(textcatalog, catalogedtext(ln; delimiter = delimiter))
            #push!(textcatalog, ln)
        end
    end
    textcatalog  |> DataFrame
end

"""Parse  a vector of CEX lines into a DataFrame of `CatalogedText`.s

$(SIGNATURES)
"""
function catalogdf_fromcex(cex::AbstractString; delimiter = "|")
    textcatalog = []
    for ln in datafortype("ctscatalog", blocks(cex))[2:end]
        push!(textcatalog, catalogedtext(ln; delimiter = delimiter))
    end
    textcatalog |> DataFrame
end

"""Parse  a vector of Unicode bytes into a DataFrame of `CatalogedText`.s

$(SIGNATURES)
"""
function catalogdf_fromcex(v::AbstractVector{UInt8}; delimiter = "|")
    catalogdf_fromcex(String(v); delimiter = delimiter)
end

"""

$(SIGNATURES)
"""
function catalogdf_fromfile(f, delimiter = "|")
   catalogdf_fromcex(read(f); delimiter = delimiter)
end


"""

"""
function catalogdf_fromurl(url, delimiter = "|")
    catalogdf_fromcex(HTTP.get(url).body; delimiter = delimiter)
end

"""Calculate number of citation levels defined for a cataloged text.
$(SIGNATURES)
"""
function citationdepth(catalogedtext::CatalogedText)
    length(split(catalogedtext.citation,","))
end


""""Find in a dataframe of catalog data the number of citation levels defined for a text identified by URN.

$(SIGNATURES)
"""    
function citationdepth(u::CtsUrn, df)
    matched = filter(row -> row.urn == u, df)
    citation = matched[1,:citation]
    length(split(citation,","))
end

=#
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

CitableTrait(::Type{CatalogedText}) = CitableByCtsUrn()


"""Override Base.== for `CatalogedText`.
$(SIGNATURES)
"""    
function ==(doc1::CatalogedText, doc2::CatalogedText)
    cex(doc1) == cex(doc2)
end

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
function cex(cataloged::CatalogedText, delimiter = "|")
    join([cataloged.urn.urn, cataloged.citation, cataloged.group, cataloged.work, cataloged.version, cataloged.exemplar, cataloged.online, cataloged.lang], delimiter)
end

"""Parse a single line of CEX data into a `CatalogedText`.
$(SIGNATURES)
"""
function catalogedtext(cexstring, delimiter = "|")
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


"""Parse  a vector of CEX lines into a DataFrame of `CatalogedText`.s

$(SIGNATURES)
"""
function catalogdf_fromcex(cexlines, delimiter = "|")
    textcatalog = []
    for ln in cexlines
        push!(textcatalog, catalogedtext(ln, delimiter))
    end
    textcatalog |> DataFrame
end


"""

$(SIGNATURES)
"""
function catalogdf_fromfile(f, delimiter = "|")
    cexblocks = read(f, String) |> blocks
    catalogblocks = blocksfortype("ctscatalog", cexblocks)

    blocklines = []
    for blk in catalogblocks
        push!(blocklines, blk.lines[2:end])
    end
    cexlines = blocklines |> Iterators.flatten |> collect
    catalogdf_fromcex(cexlines, delimiter)
end


"""

"""
function catalogdf_fromurl(url, delimiter = "|")
    cexblocks = String(HTTP.get(url).body) |> blocks
    catalogblocks = blocksfortype("ctscatalog", cexblocks)

    blocklines = []
    for blk in catalogblocks
        push!(blocklines, blk.lines[2:end])
    end
    cexlines = blocklines |> Iterators.flatten |> collect
    catalogdf_fromcex(cexlines, delimiter)
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


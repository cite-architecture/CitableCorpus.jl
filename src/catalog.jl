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


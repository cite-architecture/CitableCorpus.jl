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
    join([cataloged.urn.urn, cataloged.citation, cataloged.group, cataloged.work, cataloged.version, cataloged.exemplar, cataloged.online, cataloged.lang], "\n")
end

"""Parse a single line of CEX data into a `CatalogedText`.
$(SIGNATURES)
"""
function catalogentry(cexstring, delimiter = "|")
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
        push!(textcatalog, catalogentry(ln, delimiter))
    end
    textcatalog |> DataFrame
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



#=
"""Create a DataFrame with text catalog information from an array of raw text values.

$(SIGNATURES)
"""

function raw_to_df(arr)
    urns = map(row -> row[1], arr)
    citations = map(row -> row[2], arr)
    groups = map(row -> row[3], arr)
    works = map(row -> row[4], arr)
    versions = map(row -> row[5], arr)
    exemplars = map(row -> row[6], arr)
    onlines = map(row -> row[7], arr)
    langs = map(row -> row[8], arr)
    DataFrame(
        urn = urns,
        citation = citations,

        group = groups,
        work = works,        
        version = versions,
        exemplar = exemplars,

        online = onlines,
        lang = langs
    )
end


"""Create a DataFrame with text catalog information from an Array of `CatalogedText`s.

$(SIGNATURES)
"""
function cataloged_to_df(arr)
    urns = map(row -> row.urn, arr)
    citations = map(row -> row.citation, arr)
    groups = map(row -> row.group, arr)
    works = map(row -> row.work, arr)
    versions = map(row -> row.version, arr)
    exemplars = map(row -> row.exemplar, arr)
    onlines = map(row -> row.online, arr)
    langs = map(row -> row.lang, arr)
    DataFrame(
        urn = urns,
        citation = citations,

        group = groups,
        work = works,        
        version = versions,
        exemplar = exemplars,

        online = onlines,
        lang = langs
    )
end





"""Decompose members of a `CatalogedText` into an Array.

$(SIGNATURES)
"""
function unmarshall(entry)
    [entry.urn, entry.citation, 
    entry.group, entry.work, entry.version, entry.exemplar,
    entry.online, entry.lang]
end

"""
$(SIGNATURES)
Create a `CatalogedText` from a `CSV.Row`.
"""
function catalog(csvrow::CSV.Row)
    if length(csvrow) < 8
        throw(ArgumentError("Invalid argument $(csvrow); array should have 6 components."))
    elseif ismissing(csvrow[2])
        throw(ArgumentError("Invalid argument $(csvrow); citation scheme must be included."))
    elseif ismissing(csvrow[3])
        throw(ArgumentError("Invalid argument $(csvrow); name of text group must be included."))
    elseif ismissing(csvrow[4])
        throw(ArgumentError("Invalid argument $(csvrow); work title must be included."))
        
    else
        try
            urn = CtsUrn(csvrow[1])
            citescheme = csvrow[2]
            textgroup = csvrow[3]
            title = csvrow[4]
            vers = ismissing(csvrow[5]) ? nothing : csvrow[5]
            ex = ismissing(csvrow[6]) ? nothing : csvrow[6]
            online = csvrow[7]
            lang = csvrow[8]
            CatalogedText(urn, citescheme, textgroup, title, vers, ex, online, lang)

        catch e
            throw(e)
        end
    end
end
=#
"""Create a `CatalogedText` from an array of String values.

$(SIGNATURES)
"""
function catalog(arr)
    if length(arr) < 8
        throw(ArgumentError("Invalid argument $(arr); array should have 6 components."))
    elseif arr[2] == ""
        throw(ArgumentError("Invalid argument $(arr); citation scheme must be included."))
    elseif arr[3] == ""
        throw(ArgumentError("Invalid argument $(arr); name of text group must be included."))
    elseif arr[4] == ""
        throw(ArgumentError("Invalid argument $(arr); work title must be included."))
        
    else
        try
            urn = CtsUrn(arr[1])
            citescheme = arr[2]
            textgroup = arr[3]
            title = arr[4]
            vers = arr[5] == "" ? nothing : arr[5]
            ex = arr[6] == "" ? nothing : arr[6]
            online = lowercase(arr[7]) in ["t", "true", "yes", "y"]
            lang = arr[8]
            CatalogedText(urn, citescheme, textgroup, title, vers, ex, online, lang)

        catch e
            throw(e)
        end
    end
end

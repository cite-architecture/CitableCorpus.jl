# Functions for working with delimited-text data from Strings, Files
# or URLs, to create different types of CitableText structures.

# Types that can be loaded from delimited-text sources
loadableTypes = Union{CitableCorpus, CatalogedText}

"""
$(SIGNATURES)
Create an instance of type T from a delimited-text String.
"""
function fromdelimited(::Type{T}, src::AbstractString, delimiter::AbstractString="|")  where 
    {T <: loadableTypes} 
    lines = split(src,"\n")
    nonempty = filter(ln -> ln != "", lines)
    cols = map(l -> split(l, delimiter), nonempty)
    if T === CitableCorpus
        citablenodes = map(col -> CitableNode(CtsUrn(col[1]), col[2]), cols)
        CitableCorpus(citablenodes)
    elseif T === CatalogedText
        map(row -> catalog(row), cols)
    else
        throw(ArgumentError("Function not implemented for type $(T)."))
    end
end
    

"""
$(SIGNATURES)
Create an instance of type T from a delimited-text file with header line.
"""
function fromfile(::Type{T}, filename::AbstractString, delimiter::AbstractString="|") where 
    {T <: loadableTypes} 
    raw = CSV.File(filename, skipto=2, delim=delimiter)
    if T === CitableCorpus
        arr = raw |> Array
        corpusdata = map(row -> (CitableNode(CtsUrn(row[1]), row[2])),  arr)
        CitableCorpus(corpusdata)

    elseif T === CatalogedText
        arr = raw |> Array
        #cataloged = map(row -> catalog(row), raw)
        #map(entry -> unmarshall(entry), cataloged) |> DataFrame
        #to_df(arr)

        cataloged = map(row -> catalog(row), arr)
        cataloged_to_df(cataloged)
    else
        throw(ArgumentError("Function not implemented for type $(T)") )
    end
end


"""
$(SIGNATURES)
Create an instance of type T from a URL to a delimited-text file with header line.
"""
function fromurl(::Type{T}, url::AbstractString, delimiter::AbstractString="#") where 
    {T <: loadableTypes} 
    raw = CSV.File(HTTP.get(url).body, skipto=2, delim=delimiter)  
    if T == CitableCorpus
        arr = raw |> Array
        corpusdata = map(row -> (CitableNode(CtsUrn(row[1]), row[2])),  raw)
        CitableCorpus(corpusdata)
    elseif T === CatalogedText
        #map(row -> catalog(row), raw)
        raw |> DataFrame
    else 
        throw(ArgumentError("Function not implmented for type $(T)"))
    end
end

"Compose a delimited-text string for a corpus."
function cex(c::CitableCorpus, delimiter="|")
    txt = map(cn -> string(cn.urn.urn, delimiter, cn.text), c.corpus)
    join(txt, "\n") * "\n"
end
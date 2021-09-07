# Functions for working with delimited-text data from Strings, Files
# or URLs, to create different types of CitableText structures.

# Types that can be loaded from delimited-text sources
loadableTypes = Union{CitableTextCorpus, CatalogedText}


"""Create an instance of type T from
a file with labelled #!ctsdata blocks.

$(SIGNATURES)
"""
function fromcexfile(::Type{T}, src, delimiter::AbstractString="|")  where 
    {T <: loadableTypes} 
    blocks = CiteEXchange.fromfile(src)

    if  T === CatalogedText
        # Skip header line:
        datalines = datafortype("ctscatalog", blocks)
        data = join(datalines[2:end], "\n")
        fromdelimited(T, data, delimiter) 

    elseif T === CitableTextCorpus
        data = join(datafortype("ctsdata", blocks), "\n")
        fromdelimited(T, data, delimiter) 
    end
end


"""Create an instance of type T from
a URL source with labelled #!ctsdata blocks.

$(SIGNATURES)
"""
function fromcexurl(::Type{T}, src::AbstractString, delimiter::AbstractString="|")  where
    {T <: loadableTypes} 
    blocks = CiteEXchange.fromurl(src)
    if  T === CatalogedText
        # Skip header line:
        datalines = datafortype("ctscatalog", blocks)
        data = join(datalines[2:end], "\n")
        fromdelimited(T, data, delimiter) 

    elseif T === CitableTextCorpus
        data = join(datafortype("ctsdata", blocks), "\n")
        
        fromdelimited(T, data, delimiter) 
    end
end

"""
$(SIGNATURES)
Create an instance of type T from a delimited-text String.
"""
function fromdelimited(::Type{T}, src::AbstractString, delimiter::AbstractString="|")  where 
    {T <: loadableTypes} 
    lines = split(src,"\n")
    nonempty = filter(ln -> ln != "", lines)
    cols = map(l -> split(l, delimiter), nonempty)
    if T === CitableTextCorpus
        citablenodes = map(col -> CitableNode(CtsUrn(col[1]), col[2]), cols)
        CitableTextCorpus(citablenodes)
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
function fromdelimitedfile(::Type{T}, filename::AbstractString, delimiter::AbstractString="|") where 
    {T <: loadableTypes} 
    raw = CSV.File(filename, skipto=2, delim=delimiter)
    if T === CitableTextCorpus
        arr = raw |> Array
        corpusdata = map(row -> (CitableNode(CtsUrn(row[1]), row[2])),  arr)
        CitableTextCorpus(corpusdata)

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
function fromdelimitedurl(::Type{T}, url::AbstractString, delimiter::AbstractString="#") where 
    {T <: loadableTypes} 
    raw = CSV.File(HTTP.get(url).body, skipto=2, delim=delimiter)  
    if T == CitableTextCorpus
        arr = raw |> Array
        corpusdata = map(row -> (CitableNode(CtsUrn(row[1]), row[2])),  raw)
        CitableTextCorpus(corpusdata)
    elseif T === CatalogedText
        #map(row -> catalog(row), raw)
        raw |> DataFrame
    else 
        throw(ArgumentError("Function not implmented for type $(T)"))
    end
end

"Compose a delimited-text string for a corpus."
function cex(c::CitableTextCorpus, delimiter="|")
    # Rm newlines from output.
    txt = map( cn -> string(
            cn.urn.urn, delimiter, 
            replace(cn.text, "\n" => " ")), 
            c.corpus)
    join(txt, "\n") * "\n"
end
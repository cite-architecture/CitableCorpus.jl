# Functions for loading catalog data from delimited-text from Strings, File or URLs.


"""Create a Vector of `CatalogedText` entries from a file with labelled #!ctscatalog blocks.

$(SIGNATURES)
"""
function catalog_fromcexfile(src, delimiter::AbstractString="|")
    blocks = CiteEXchange.fromfile(src)
    data = join(datafortype("ctsdata", blocks), "\n")
    fromdelimited(data, delimiter) 
end


"""Create a Vector of `CatalogedText` entries from
a URL source with labelled #!ctsdata blocks.

$(SIGNATURES)
"""
function catalog_fromcexurl(src::AbstractString, delimiter::AbstractString="|")
    blocks = CiteEXchange.fromurl(src)
    # Skip header line:
    datalines = datafortype("ctscatalog", blocks)
    data = join(datalines[2:end], "\n")
    catalog_fromdelimited(data, delimiter) 
end

"""Create a `CatalogedText` from a delimited-text String.

$(SIGNATURES)
"""
function catalog_fromdelimited(src::AbstractString, delimiter::AbstractString="|")  
    lines = split(src,"\n")
    nonempty = filter(ln -> ln != "", lines)
    cols = map(l -> split(l, delimiter), nonempty)
    map(row -> catalog(row), cols)
end
    

"""Create a DataFrame from catalog data in a delimited-text file.

$(SIGNATURES)
"""
function df_fromfile(filename::AbstractString, delimiter::AbstractString="|")
    arr = CSV.File(filename, skipto=2, delim=delimiter) |> Array
    cataloged = map(row -> catalog(row), arr)
    cataloged_to_df(cataloged)

        #cataloged = map(row -> catalog(row), raw)
        #map(entry -> unmarshall(entry), cataloged) |> DataFrame
        #to_df(arr)
end


"""Create an DataFrame from catalog data read from a URL.
$(SIGNATURES)
"""
function df_fromurl(url::AbstractString, delimiter::AbstractString="#")
    CSV.File(HTTP.get(url).body, skipto=2, delim=delimiter)  |> DataFrame
end


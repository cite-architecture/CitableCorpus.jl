# Functions for working with delimited-text data from Strings, Files
# or URLs, to create different types of CitableText structures.

# Types that can be loaded from delimited-text sources
#loadableTypes = Union{CitableTextCorpus, CatalogedText}


"""Create  a `CitableTextCorpus`from a file with labelled #!ctsdata blocks.

$(SIGNATURES)
"""
function corpus_fromcexfile(src, delimiter::AbstractString="|")
    blocks = CiteEXchange.fromfile(src)
    data = join(datafortype("ctsdata", blocks), "\n")
    corpus_fromdelimited(data, delimiter)  
end


"""Create  a `CitableTextCorpus` from from
a URL source with labelled #!ctsdata blocks.

$(SIGNATURES)
"""
function corpus_fromcexurl(src::AbstractString, delimiter::AbstractString="|") 
    blocks = CiteEXchange.fromurl(src)
    data = join(datafortype("ctsdata", blocks), "\n")
    corpus_fromdelimited(data, delimiter) 
    
end

"""Create  a `CitableTextCorpus` from a delimited-text String.

$(SIGNATURES)
"""
function corpus_fromdelimited(src::AbstractString, delimiter::AbstractString="|") 
    lines = split(src,"\n")
    nonempty = filter(ln -> ln != "", lines)
    cols = map(l -> split(l, delimiter), nonempty)
    citablenodes = map(col -> CitablePassage(CtsUrn(col[1]), col[2]), cols)
    CitableTextCorpus(citablenodes)
end
    
"""Create  a `CitableTextCorpus` from a delimited-text file with header line.

$(SIGNATURES)
"""
function corpus_fromfile(filename::AbstractString, delimiter::AbstractString="|") 
    raw = CSV.File(filename, skipto=2, delim=delimiter)
    arr = raw |> Array
    corpusdata = map(row -> (CitablePassage(CtsUrn(row[1]), row[2])),  arr)
    CitableTextCorpus(corpusdata)
end


"""Create  a `CitableTextCorpus` from a URL to a delimited-text file with header line.

$(SIGNATURES)
"""
function corpus_fromurl(url::AbstractString, delimiter::AbstractString="#") 
    arr = CSV.File(HTTP.get(url).body, skipto=2, delim=delimiter)  |> Array
    corpusdata = map(row -> (CitablePassage(CtsUrn(row[1]), row[2])),  arr)
    CitableTextCorpus(corpusdata)
   
end

"""Compose a delimited-text string for a corpus.

$(SIGNATURES)
"""
function cex(c::CitableTextCorpus, delimiter="|")
    # Rm newlines from output.
    txt = map( cn -> string(
            cn.urn.urn, delimiter, 
            replace(cn.text, "\n" => " ")), 
            c.corpus)
    join(txt, "\n") * "\n"
end

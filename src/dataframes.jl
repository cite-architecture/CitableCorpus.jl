# DataFrames

# TEXT CATALOG STUFF:
#=

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

=#




#= CORPUS STUFF


"""
$(SIGNATURES)
Create a DataFrame from a `CitableTextCorpus`
"""
function textdf(c::CitableTextCorpus)
    c.passages |> DataFrame
end


=#
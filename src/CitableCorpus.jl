module CitableCorpus

using CitableText
using CSV, DataFrames, HTTP
using Documenter, DocStringExtensions

export CitableNode, CitableTextCorpus
export fromdelimited, fromfile, fromurl,
  nextnode, prevnode,
  combine, composite_array,
  retrieve
export to_df, cex

export CatalogedText
export catalog, cataloged_to_df, citationdepth
export textgroup

include("citableNode.jl")
include("catalog.jl")
include("readcatalog.jl")

include("corpus.jl")

include("retrieval.jl")
include("navigation.jl")

include("delimited.jl")

end # module

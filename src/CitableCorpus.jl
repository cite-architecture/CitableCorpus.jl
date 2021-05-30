module CitableCorpus
using CitableText

export CitableNode, CitableCorpus
export fromdelimited, fromfile, fromurl,
  nextnode, prevnode,
  combine, composite_array,
  retrieve
export to_df, cex

export CatalogedText
export catalog, cataloged_to_df, citationdepth

include("citableNode.jl")
include("catalog2.jl")

include("corpus.jl")

include("retrieval.jl")
include("navigation.jl")

include("delimited.jl")

end # module

module CitableCorpus

#export CitableNode#, CitableCorpus
#export fromdelimited, fromfile, fromurl,
#  nextnode, prevnode,
#  combine, composite_array
  #retrieve
#export to_df, cex

#export CatalogedText
#export catalog, cataloged_to_df, citationdepth
include("citableNode.jl")
include("catalog.jl")

include("corpus.jl")

end # module

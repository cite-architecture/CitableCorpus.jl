module CitableCorpus

using CitableText
using CiteEXchange
using CSV, DataFrames, HTTP
using Documenter, DocStringExtensions
#using TextAnalysis
#using TopicModelsVB

export CitableNode, CitableTextCorpus
export fromdelimited, fromdelimitedfile, fromdelimitedurl
export fromcexfile, fromcexurl
export nextnode, prevnode, retrieve
export combine, composite_array
export to_df, cex

export CatalogedText
export catalog, cataloged_to_df, citationdepth
export groupname, worktitle, versionlabel, exemplarlabel
export citationlabels, online, lang

export tacorpus, talexicon, dtmatrix
export tmcorpus

include("citableNode.jl")
include("catalog.jl")
include("readcatalog.jl")

include("corpus.jl")

include("retrieval.jl")
include("navigation.jl")

include("delimited.jl")

#include("textanalysis.jl")
#include("topicmodels.jl")

end # module

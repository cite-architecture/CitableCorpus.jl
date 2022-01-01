using CitableCorpus
using CitableBase
using CitableText
using CiteEXchange
using DataFrames, HTTP
using Test

include("test_citable_passages.jl")
include("test_citable_document.jl")
#=
include("test_library.jl")




include("test_corpus.jl")
include("test_navigation.jl")
include("test_retrieval.jl")

include("test_catalog.jl")

include("test_readcatalog.jl")
include("test_cex.jl")

include("test_trait.jl")
=#

# Only include this if you're online:
# include("test_online.jl")
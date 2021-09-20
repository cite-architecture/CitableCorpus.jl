module CitableCorpus


import Base:  print
import Base:  ==

import CitableBase: cex
import CitableBase: urn
import CitableBase: label

using CitableBase
using CitableText
using CiteEXchange
using CSV, DataFrames, HTTP
using Documenter, DocStringExtensions


# Citable functions from CitableBase 3.0.0
export urn, label, cex

export CitablePassage, CitableDocument, CitableTextCorpus


export corpus_fromcex, document_fromcex, textdf
export combine
export next, prev, retrieve
export document_urns, documents, document

export CatalogedText
export catalog, cataloged_to_df, citationdepth
export groupname, worktitle, versionlabel, exemplarlabel
export citationlabels, online, lang


include("citablePassage.jl")
include("citableDocument.jl")
include("corpus.jl")
include("navigation.jl")


include("retrieval.jl")


include("catalog.jl")
include("readcatalog.jl")
include("catalog_delimited.jl")





end # module

module CitableCorpus

import Base:  print
#import Base:  length

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
export corpus_fromdelimited, corpus_fromfile, corpus_fromurl, corpus_fromcexurl, corpus_fromcexfile
export catalog_fromdelimited, catalog_fromcexurl, catalog_fromcexfile
export df_fromfile, df_fromurl
export fromcexfile, fromcexurl
export nextpassage, prevpassage, retrieve
export combine, composite_array
export to_df, cex

export CatalogedText
export catalog, cataloged_to_df, citationdepth
export groupname, worktitle, versionlabel, exemplarlabel
export citationlabels, online, lang



include("citablePassage.jl")
include("citableDocument.jl")



include("catalog.jl")
include("readcatalog.jl")

include("corpus.jl")
include("retrieval.jl")
include("navigation.jl")

include("corpus_delimited.jl")
include("catalog_delimited.jl")


end # module

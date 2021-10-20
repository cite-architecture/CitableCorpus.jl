module CitableCorpus


import Base:  print
import Base:  show
import Base:  ==

using CitableBase
import CitableBase: CitableTrait
import CitableBase: cex
import CitableBase: urn
import CitableBase: label


using CitableText
using CiteEXchange
using DataFrames, HTTP
using Documenter, DocStringExtensions


# Citable functions from CitableTrait interface
export urn, label, cex

export CitablePassage, CitableDocument, CitableTextCorpus

export corpus_fromcex, document_fromcex, textdf
export combine
export next, prev, retrieve
export document_urns, documents, document
export passage_count

export CatalogedText
export catalogedtext
export catalogdf_fromcex, catalogdf_fromfile, catalogdf_fromurl

export groupname, worktitle, versionlabel, exemplarlabel
export citationlabels, online, lang
export citationdepth


include("citablePassage.jl")
include("citableDocument.jl")
include("corpus.jl")
include("navigation.jl")


include("retrieval.jl")


include("catalog.jl")
include("readcatalog.jl")
#include("catalog_delimited.jl")





end # module

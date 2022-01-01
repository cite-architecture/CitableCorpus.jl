module CitableCorpus


#import Base:  print
import Base:  show
import Base:  ==
import Base: iterate

using CitableBase

import CitableBase: citabletrait
import CitableBase: urn
import CitableBase: label


import CitableBase: cex
import CitableBase: fromcex

import CitableBase: urncontains
import CitableBase: urnequals


using CitableText
using CiteEXchange
using DataFrames, HTTP
using Documenter, DocStringExtensions


# Citable functions from CitableTrait interface
#export urn, label, cex, fromcex
#export urnequals, urncontains


export CitablePassage
export PassageCitableByCtsUrn, CtsUrnComparablePassage, CexPassage
#export CitableDocument
#export CitableTextCorpus

#=
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

=#
include("citablePassage.jl")

#include("citableDocument.jl")
#include("corpus.jl")
#include("navigation.jl")
#include("retrieval.jl")


#=
include("catalog.jl")
include("readcatalog.jl")
=#

end # module

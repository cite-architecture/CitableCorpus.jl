module CitableCorpus

using CitableBase
using CitableText
using CiteEXchange
using DataFrames, HTTP
using Documenter, DocStringExtensions

import Base:  show
import Base:  ==
import Base: iterate

import CitableBase: citabletrait
import CitableBase: urn
import CitableBase: label

import CitableBase: cextrait
import CitableBase: cex
import CitableBase: fromcex

import CitableBase: urncomparisontrait
import CitableBase: urncontains
import CitableBase: urnequals
import CitableBase: urnsimilar

import CitableBase: citablecollectiontrait


export CatalogedText, entry
export citation, textgroup, work, version, exemplar
export lang, online

export TextCatalogCollection



export CitablePassage
export PassageCitableByCtsUrn, CtsUrnComparablePassage, CexPassage
export text



export CitableDocument
export DocumentCitableByCtsUrn, CtsUrnComparableDocument, CexDocument


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


include("catalogentry.jl")
include("catalogcollection.jl")

include("citablePassage.jl")
include("citableDocument.jl")


#include("corpus.jl")
#include("navigation.jl")
#include("retrieval.jl")

include("dataframes.jl")

#=
include("catalog.jl")
include("readcatalog.jl")
=#

end # module

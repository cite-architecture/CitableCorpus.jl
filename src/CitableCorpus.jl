module CitableCorpus

using CitableBase
using CitableText
using CiteEXchange

using Tables
import Tables: istable
import Tables: rows
import Tables: columns

using HTTP

using Documenter, DocStringExtensions

import Base:  show
import Base:  ==
import Base: iterate, length, eltype

using CitableBase

import CitableBase: citabletrait
import CitableBase: urntype
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

export CatalogedText
export CitableTextEntry, CtsComparableTextCatalogEntry, CexCatalogedText
export entry
export citation, citationdepth
export textgroup, work, version, exemplar
export lang, online

export TextCatalogCollection
export CitableTextCatalog

export CitablePassage
export PassageCitableByCtsUrn, CtsUrnComparablePassage, CexPassage
export text

export CitableDocument
export DocumentCitableByCtsUrn, CtsUrnComparableDocument, CexDocument

export CitableTextCorpus
export CitableCorpusTrait, CtsComparableCorpus, CexCorpus

export document_urns

export select

#=
export combine
export next, prev
export document_urns, documents, document
export passage_count
=#


include("catalogentry.jl")
include("catalogcollection.jl")

include("citablePassage.jl")
include("corpus.jl")

include("citableDocument.jl")

include("utils.jl")


end # module

# Citable nodes and corpora


## Citable passages

A `CitableNode` has two members: a URN, and a string of text.  You can apply all of the `CitableText` module's functions for working with URNs to the `CitableNode`'s URN.


```jldoctest corpus
using CitableCorpus
using CitableText

urn = CtsUrn("urn:cts:citedemo:gburg.bancroft.v1:1")
txt = "Four score and seven years ago our fathers brought forth, on this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal."
cn = CitableNode(urn, txt)
cn.urn |> passagecomponent

# output

"1"
```


```jldoctest corpus
cn.text

# output

"Four score and seven years ago our fathers brought forth, on this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal."
```


## Citable corpus

A `CitableCorpus` has a sequence of `CitableNode`s. You can load a `CitableCorpus` from delimited files, or CEX sources.  (Under the hood, the module uses the [CiteEXchange](https://cite-architecture.github.io/CiteEXchange.jl/stable/) module to load CEX sources.)

TBA: examples of

- df_fromfile
- df_fromurl
- fromcexfile
- fromcexurl


### Navigating a citable corpus


TBA
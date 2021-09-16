# Citable passages, documents and corpora


## Citable passages

A `CitablePassage` has two members: a URN, and a string of text.  You can apply all of the `CitableText` module's functions for working with URNs to the `CitablePassage`'s URN.


```jldoctest corpus
using CitableCorpus
using CitableText

psgurn = CtsUrn("urn:cts:citedemo:gburg.bancroft.v1:1")
txt = "Four score and seven years ago our fathers brought forth, on this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal."
psg = CitablePassage(psgurn, txt)
urn(psg) |> passagecomponent

# output

"1"
```


```jldoctest corpus
psg.text

# output

"Four score and seven years ago our fathers brought forth, on this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal."
```

## Citable document

A citable document has a title, a `CtsUrn`, and a Vector of `CitablePassages`.  Here we'll manually create a very short document with just the first passage of Bancroft's text.

```jldoctest corpus
bancroft = droppassage(psgurn)
doc = CitableDocument(bancroft, "Bancroft's text of the Gettysburg Address", [psg])

# output


```
 CitableCorpus includes functions that fulfill the contract of the `Citable` abstraction in the `CitableBase` module. 

## Citable text corpus

A `CitableCorpus` has a sequence of `CitablePassage`s. You can load a `CitableCorpus` from delimited files, or CEX sources.  (Under the hood, the module uses the [CiteEXchange](https://cite-architecture.github.io/CiteEXchange.jl/stable/) module to load CEX sources.)

TBA: examples of

- df_fromfile
- df_fromurl
- fromcexfile
- fromcexurl


### Navigating documents and corpora


TBA
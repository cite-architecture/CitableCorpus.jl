# Citable passages, documents and corpora


## Citable passages

A `CitablePassage` has two members: a URN, and a string of text.  You can apply all of the `CitableText` module's functions for working with URNs to the `CitablePassage`'s URN.


```jldoctest corpus
using CitableCorpus
using CitableText

psgurn = CtsUrn("urn:cts:citedemo:gburg.bancroft.v2:1")
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

## Citable documents

A `CitableDocument` has a title, a `CtsUrn`, and a Vector of `CitablePassages`.  Here we'll manually create a very short document with just the first passage of Bancroft's text of the Gettysburg Address.

```jldoctest corpus
bancroft = droppassage(psgurn)
doc = CitableDocument(bancroft, "Bancroft's text of the Gettysburg Address", [psg])

# output

"Bancroft's text of the Gettysburg Address <urn:cts:citedemo:gburg.bancroft.v2:> 1 citable passage"
```

CitableCorpus includes functions that fulfill the contract of the `Citable` abstraction in the `CitableBase` module. 

```jldoctest corpus
label(doc)

# output

"Bancroft's text of the Gettysburg Address"
```

```jldoctest corpus
urn(doc)

# output

urn:cts:citedemo:gburg.bancroft.v2:
```

## Citable text corpus

A `CitableCorpus` has a sequence of `CitablePassage`s. 


## I/O with documents and corpora

The `text_fromcex` and `corpus_fromcex` functions read `ctsdata` sections from a string formatted in CITE Data Exchange (CEX) format.

```jldoctest corpus
cexsrc = join([
    "#!ctsdata",
    "// Bancroft's text of the Gettysburg Address, urn:cts:citedemo:gburg.bancroft.v2:",
    "// 1 citable passages.",
    "//",
    "urn:cts:citedemo:gburg.bancroft.v2:1|Four score and seven years ago our fathers brought forth, on this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal."], "\n")
document_fromcex(cexsrc)    

# output

"Citable document <urn:cts:citedemo:gburg.bancroft.v2:> 1 citable passage"
```    

You can use these functions together with normal Julia I/O functions to read CEX data from files, URLs, or other data sources.


```jldoctest corpus
f = "data/gettysburgcorpus.cex"
gburgcorpus = read(f, String) |> corpus_fromcex
gburgcorpus.passages |> length

# output

20
```

```jldoctest corpus

bancroftdoc = document_fromcex(read(f, String), docurn=bancroft, title="Bancroft's text of the Gettysburg address")
bancroftdoc.passages |> length

# output

4
```


### Navigating documents and corpora


TBA
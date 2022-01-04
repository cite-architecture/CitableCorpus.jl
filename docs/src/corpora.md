# Citable corpora

The `CitableTextCorpus` is a wrapper around a Vector of `CitablePassage`s.  You can construct one from a Vector `CitablePassage`s.

```@example corp
using CitableCorpus
using CitableText

bancroft1 = CtsUrn("urn:cts:citedemo:gburg.bancroft.v2:1")
everett1 = CtsUrn("urn:cts:citedemo:gburg.everett.v2:1")
psgs = [
    CitablePassage(bancroft1, "Four score and seven years ago our fathers brought forth, on this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal."),
    CitablePassage(everett1, "Four score and seven years ago our fathers brought forth, upon this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal.")
]
corpus = CitableTextCorpus(psgs)
```

The `CitableTextCorpus` implements the `CitableCollectionTrait`, and therefore supports URN comparison and CEX serialization.

```@example corp
using CitableBase
citablecollection(corpus)
```
```@example corp
cexserializable(corpus)
```
```@example corp
urncomparable(corpus)
```

In addition, it implements Julia's `Iterators` behavior.

## Urn comparison and filtering

```@example corp
urnequals(everett1, corpus)
```

```@example corp
allgburg = CtsUrn("urn:cts:citedemo:gburg:")
urncontains(allgburg, corpus)
```


```@example corp
allgburg = CtsUrn("urn:cts:citedemo:gburg:")
urnsimilar(allgburg, corpus)
```


## CEX serialization


```@example corp
corpuscex = cex(corpus)
```

```@example catalog
fromcex(corpuscex, CitableTextCorpus) == corpus
```


 ## Iteration

```@example corp
length(corpus)
```

```@example corp
eltype(corpus)
```

```@example corp
collect(corpus)
```

```@example corp
for psg in corpus
    println(psg)
end
```
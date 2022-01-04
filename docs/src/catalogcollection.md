# Text catalog

A `TextCatalogCollection` is a wrapper around a Vector of `CatalogedText`s. You can construct one from a Vector of `CatalogedText`s.

```@example catalog
using CitableCorpus
using CitableText

hay_urn = CtsUrn("urn:cts:citedemo:gburg.hay.v2:")
hay = entry(hay_urn, "section", "Gettysburg Address", "Text of John Hay", "second HC digital edition")
everett_urn = CtsUrn("urn:cts:citedemo:gburg.everett.v2:")
everett = entry(everett_urn, "section", "Gettysburg Address", "Text of Edward Everett", "second HC digital edition")
catalog = TextCatalogCollection([hay, everett])
```

 The `TextCatalogCollection` implements the `CitableCollectionTrait`, which implies that it also implements URN comparison and CEX serialiation

 ```@example catalog
using CitableBase
citablecollection(catalog)
```

```@example catalog
cexserializable(catalog)
```


```@example catalog
urncomparable(catalog)
```

In addition, it implements Julia's `Iterators` behavior, as we'll see below.

 ## Urn comparison and filtering

 ```@example catalog
urnequals(hay_urn, catalog)
```

```@example catalog
allgburg = CtsUrn("urn:cts:citedemo:gburg:")
urncontains(allgburg, catalog)
```


```@example catalog
urnsimilar(allgburg, catalog)
```

## CEX serialization

```@example catalog
catcex =cex(catalog)
```

```@example catalog
fromcex(catcex, TextCatalogCollection) == catalog
```


 ## Iteration

```@example catalog
length(catalog)
```

```@example catalog
eltype(catalog)
```

```@example catalog
collect(catalog)
```

 ```@example catalog
for entry in catalog
    println(entry)
end
```
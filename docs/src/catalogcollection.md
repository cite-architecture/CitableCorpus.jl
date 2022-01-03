# Text catalog

A `TextCatalogCollection` is a wrapper around a Vector of `CatalogedText`s. You can construct one from a Vector of `CatalogedText`s.

```@example catalog
using CitableCorpus
using CitableText

hay = entry(CtsUrn("urn:cts:citedemo:gburg.hay.v2:"), "section", "Gettysburg Address", "Text of John Hay", "second HC digital edition")
everett = entry(CtsUrn("urn:cts:citedemo:gburg.everett.v2:"), "section", "Gettysburg Address", "Text of Edward Everett", "second HC digital edition")
catalog = TextCatalogCollection([hay, everett])
```

 The `TextCatalogCollection` implements the `CitableCollectionTrait`, which implies that it also implements URN comparison and CEX serialiation

 ```@example catalog
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

 

## CEX serialization


 ## Iteration
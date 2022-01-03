# A text catalog entry

A `CatalogedText` identifies a concrete version of a text by CTS URN, and records labels for its citation pattern and work hierarchy.  You can create a `CatalogedText` with the `entry` function.

```@example catentry
using CitableCorpus
using CitableText

catentry = entry(CtsUrn("urn:cts:citedemo:gburg.hay.v2:"), "section", "Gettysburg Address", "Text of John Hay", "second HC digital edition")
```

!!! note "Default values"

    Notice that the `entry` function has supplied default values for the `exemplar`, `online` and `lang` fields.  You can override those defaults with optional parameters.


Access values of the cataloged entry with these functions:

```@example catentry
citation(catentry)
```


```@example catentry
textgroup(catentry)
```

```@example catentry
work(catentry)
```
```@example catentry
version(catentry)
```
```@example catentry
exemplar(catentry)
```
```@example catentry
lang(catentry)
```




## A citable object

A `CatalogedText` follows `CtsBase`'s definition of a [*citable object*](https://cite-architecture.github.io/CitableBase.jl/stable/citable/).   It therefore implements three traits defining behavior for *citation*, *comparison based on URN logic*, and *serialization to/from CEX format*.



```@example passage
using CitableBase
citable(catentry)
```

```@example passage
urncomparable(catentry)
```

```@example passage
cexserializable(catentry)
```


### Citation

The `label` and `urn` functions are available from `CitableBase`.

```@example passage
label(catentry)
```
```@example passage
urn(catentry)
```

### URN comparison


`CatalogedText`s can be compared to URNs using [URN logic for equality, containment and similarity](https://cite-architecture.github.io/CitableBase.jl/stable/).   Note that in each function, the first parameter is the catalog entry, and the second a URN to compare the text to.

```@example passage
urnequals(catentry, catentry.urn)
```
```@example passage
allgburg = CtsUrn("urn:cts:citedemo:gburg:")
urncontains(catentry, allgburg)
```
```@example passage
urnsimilar(catentry, allgburg)
```

### CEX serialization

`CitablePassage`s can be lossly roundtripped to and from objects and delimited-text strings in CEX format using the `cex` and `fromcex` functions of `CitableBase`.

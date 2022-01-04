# A text catalog entry

A `CatalogedText` identifies a concrete version of a text by CTS URN, and records labels for its citation pattern and work hierarchy.  You can create a `CatalogedText` with the `entry` function.

```@example catentry
using CitableCorpus
using CitableText

hay_urn = CtsUrn("urn:cts:citedemo:gburg.hay.v2:")
catentry = entry(hay_urn, "section", "Gettysburg Address", "Text of John Hay", "second HC digital edition")
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
exemplar(catentry) |> isnothing
```
```@example catentry
lang(catentry)
```


## A citable object

A `CatalogedText` follows `CtsBase`'s definition of a [*citable object*](https://cite-architecture.github.io/CitableBase.jl/stable/citable/).   It therefore implements three traits defining behavior for (1) *citation*, (2) *comparison based on URN logic*, and (3) *serialization to/from CEX format*. You can verify that with the following functions from `CitableBase`.



```@example catentry
using CitableBase
citable(catentry)
```

```@example catentry
urncomparable(catentry)
```

```@example catentry
cexserializable(catentry)
```


### Citation

The `label` and `urn` functions are available for citable objects.

```@example catentry
label(catentry)
```
```@example catentry
urn(catentry)
```

### URN comparison


`CatalogedText`s can be compared to URNs using [URN logic for equality, containment and similarity](https://cite-architecture.github.io/CitableBase.jl/stable/).   Note that in each function, the first parameter is the catalog entry, and the second a URN to compare the text to.

```@example catentry
urnequals(catentry, hay_urn)
```
```@example catentry
allgburg = CtsUrn("urn:cts:citedemo:gburg:")
urncontains(catentry, allgburg)
```
```@example catentry
urnsimilar(catentry, allgburg)
```

### CEX serialization

`CitablePassage`s can be lossly roundtripped to and from objects and delimited-text strings in CEX format using the `cex` and `fromcex` functions of `CitableBase`.


```@example catentry
cex(catentry)
```


```@example catentry
fromcex(cex(catentry), CatalogedText) == catentry
```
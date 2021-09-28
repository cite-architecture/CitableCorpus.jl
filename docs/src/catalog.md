# Citable Text Catalogs


## A single catalog entry

A `CatalogedText` has the following information about an individual text:

1. its URN
2. its citation scheme, expressed as a comma-delimited string labeling each tier of the hierarchy.  In the example here, the citation scheme has two levels labeled "chapter" and "section".
3. A text group
4. A work title
5. A version identifier
6. An exemplar (here, empty)
7. Whether the text is online
8. The language of the text, identified by 3-letter ISO code.

The `catalogedtext` function creates a `CatalogedText` from a single line of data in delimited-text format.

```jldoctest catalog
using CitableCorpus
data = "urn:cts:latinLit:stoa1263.stoa001.hc:|chapter,section|Hyginus|Fabulae|Holy Cross edition||true|lat"
cataloged = catalogedtext(data)
cataloged.group

# output

"Hyginus"
```

A `CatalogedText` implements the `Citable` interface (from the `CitableBase` module), so you can use its `urn`, `label` and `cex` functions.


```jldoctest catalog
using CitableBase
urn(cataloged)

# output

urn:cts:latinLit:stoa1263.stoa001.hc:
```

```jldoctest catalog
label(cataloged)

# output

"Hyginus, Fabulae, (Holy Cross edition)"
```


## A collection of cataloged texts

You can read a collection of `CatalogedText`s into a DataFrames from delimited-text strings, files or URLs.


```jldoctest catalog
url = "https://raw.githubusercontent.com/cite-architecture/CitableCorpus.jl/dev/docs/data/gettysburgcatalog.cex"
df = catalogdf_fromurl(url)
typeof(df)

# output

DataFrame
```

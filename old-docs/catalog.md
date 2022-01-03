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

A `CatalogedText` implements the `CitableTrait` (from the `CitableBase` module), so you can use the `urn`, `label` and `cex` functions as you would with any implementation of a `CitableTrait`.


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

You can read a collection of `CatalogedText`s into a DataFrame from delimited-text strings, files or URLs.


```jldoctest catalog
url = "https://raw.githubusercontent.com/cite-architecture/CitableCorpus.jl/dev/docs/data/gettysburgcatalog.cex"
df = catalogdf_fromurl(url)
typeof(df)

# output

DataFrames.DataFrame
```

You can, of course, work with this as you would with any DataFrame, including applying functions from the `CitableText` module to filter rows using URN logic.  For example, you could count how many texts belong to the `gburg` group.



```jldoctest catalog
using DataFrames, CitableText
groupurn = CtsUrn("urn:cts:citedemo:gburg:")
filter(r -> urncontains(groupurn, r.urn), df) |> nrow

# output

5
```

`CitableCorpus` also provides short-hand functions for finding each of the property values of a cataloged text identified by URN.  (See the API documentation for a full list.)


```jldoctest catalog
hay = CtsUrn("urn:cts:citedemo:gburg.hay.v2:")
worktitle(df, hay)

# output

"Hay's text"
```

If the URN you query for with these functions matches 0 or more than one row, you will receive a warning, and the return value will be `nothing`.


```
worktitle(df, groupurn) |> isnothing

# output

true
```
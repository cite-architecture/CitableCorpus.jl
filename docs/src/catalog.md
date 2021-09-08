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
8. The languagej of the text, identified by 3-letter ISO code.


```jldoctest catalog
using CitableCorpus
data = "urn:cts:latinLit:stoa1263.stoa001.hc:|chapter,section|Hyginus|Fabulae|Holy Cross edition||true|lat"
columns = split(data, "|")
cataloged = catalog(columns)
cataloged.group

# output

"Hyginus"
```


## A collection of cataloged texts

You can create either Vectors of `CatalogedText`s or DataFrames with catalog data from delimited-text sources.

- catalog_fromdelimited
- df_fromfile, df_fromurl
- fromcexfile, fromcexurl
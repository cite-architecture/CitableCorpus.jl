# CitableCorpus.jl

The CitableCorpus.jl package defines functions for working with the following structures:

- a `CatalogedText` text associates labelling metadata with an identifying URN for a concrete version of a text.
- a `TextCatalogCollection` is a collection of `CatalogedText`s.
- a `CitablePassage` represents a passage of text.  It associates a `CtsUrn` with a string value for the content of the passage.
- a `CitableTextCorpus` contains an ordered list of `CitablePassages` belonging to one or more versions of one or more texts.


!!! note "In development"

    The next release of `CitableCorpus` is planned to include `CitableDocument` and `CitableDocumentCollection` types. The `CitableDocument` represents a single cataloged document. It associates an ordered list of `CitablePassages`, all belonging to a single version of a single text, with a `CatalogedText`.  The `CitableDocumentCollection` is list of `CitableDocument`s.





The behaviors of these structures are defined by the traits from [the `CitableBase` package](https://cite-architecture.github.io/CitableBase.jl/stable/) that each one fulfills.


Both the `TextCatalogCollection` and the `CitableTextCorpus` are *citable collections*, and therefore implement Julia's interface for iterators. This means that you can apply any function to them that you can use for other iterable collections.  `for psg in corpus`, for example, iterates through all passages in `corpus`.



## User's guide 

The following pages document each of the above structures. Throughout our examples, we will work with a citable corpus of [the five extant versions of the Gettysburg Address](http://www.abrahamlincolnonline.org/lincoln/speeches/gettysburg.htm). 

!!! tip "Data files"
    
    You can find the text corpus serialized in CEX format in the file `gettysburgcorpus.cex` of this repository's `test/data` directory. In the same directory, the file `gettysburgcatalog.cex` has a CEX representation of the catalog for that corpus.



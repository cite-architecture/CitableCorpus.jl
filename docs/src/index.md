# CitableCorpus.jl

The CitableCorpus.jl package defines functions for working with four structures.  

- a `CitablePassage` represents a passage of text.  It associates a `CtsUrn` with a string value for the content of the passage.
- a `CitableDocument` contains an ordered list of `CitablePassages`, all belonging to a single version of a single text.
- a `CitableTextCorpus` contains an ordered list of `CitablePassages` belonging to one or more versions of one or more texts.
- a `CatalogedText` contains catalog information for a single citable text document.



The behaviors of these structures are defined by the traits from [the `CitableBase` package](https://cite-architecture.github.io/CitableBase.jl/stable/) that each one fulfills.


Both the `CitableDocument` and the `CitableTextCorpus` are *citable collections*, and therefore  implement Julia's interface for iterators. This means that you can apply any function to them that you can use for other iterable collections.  `for psg in document`, for example, iterates through all passages in `document`.



## User's guide 

The following pages document each of `CitableCorpus`' four structures. Throughout our examples, we'll work with a citable corpus of [the five extant versions of the Gettysburg Address](http://www.abrahamlincolnonline.org/lincoln/speeches/gettysburg.htm). 


> TBA: add link to corpus and catalog cex files.
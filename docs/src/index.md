# CitableCorpus.jl

The CitableCorpus.jl package defines functions for working with:  

- a `CitablePassage` represents a passage of text.  It associates a `CtsUrn` with a string value for the content of the passage.
- a `CitableDocument` contains an ordered list of `CitablePassages`, all belonging to a single version of a single text.
- a `CitableTextCorpus` contains an ordered list of `CitablePassages` belonging to one or more versions of one or more texts.
- a `CatalogedText` contains catalog information for a single citable text document.

Both the `CitableDocument` and the `CitableTextCorpus`  implement Julia's interface for iterators, so you can apply any function to them that you can use for other iterable collections.  `for psg in document`, for example, iterates through all passages in `document`.
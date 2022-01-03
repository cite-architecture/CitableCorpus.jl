# Citable passages

A `CitablePassage` represents a single canonically citable unit of text which you construct with a `CtsUrn` and a string value.  Here we create a `CitablePassage` for the opening sentence of the Gettysburg Address in the version of John Hay, now in the Library of Congress.

```@example passage
using CitableCorpus
using CitableText

hay_urn = CtsUrn("urn:cts:citedemo:gburg.hay.v2:1")
hay_txt = "Four score and seven years ago our fathers brought forth, upon this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal."
hay_psg = CitablePassage(hay_urn, hay_txt)
```

Use the `text` function to find the text content of a passage.

```@example passage
text(hay_psg)
```



`CitablePassage`s can be compared used the `==` function of Julia `Base`.

```@example passage
duplicate = hay_psg
hay_psg == duplicate
```

Note that two passages are equal only if both their text and URNs match.  Here is the opening sentence of Lincoln's address in the version of Edward Everett, the principal speaker at Gettysburg.

```@example passage
everett_urn = CtsUrn("urn:cts:citedemo:gburg.everett.v2:1")
everett_txt = "Four score and seven years ago our fathers brought forth, upon this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal."
everett_psg = CitablePassage(everett_urn, everett_txt)
```

Two different passages may have identical text content.

```@example passage
text(hay_psg) == text(everett_psg)
```

```@example passage
hay_psg == everett_psg
```





## A citable object

A `CitablePassage` follows `CtsBase`'s definition of a [*citable object*](https://cite-architecture.github.io/CitableBase.jl/stable/citable/).   It therefore must implement three traits defining behavior for *citation*, *comparison based on URN logic*, and *serialization to/from CEX format*.


```@example passage
using CitableBase
citable(everett_psg)
```

```@example passage
urncomparable(everett_psg)
```

```@example passage
cexserializable(everett_psg)
```

### Citation

The `label` and `urn` functions are available from `CitableBase`.

```@example passage
label(everett_psg)
```


```@example passage
urn(everett_psg)
```


Since `CitablePassage`s are cited by `CtsUrn`, you can use any functions from [the `CitableText` package](https://cite-architecture.github.io/CitableText.jl/stable/guide/).

```@example passage
urn(everett_psg) |> passagecomponent
```

## URN comparison


`CitablePassage`s can be compared to URNs using [URN logic for equality, containment and similarity](https://cite-architecture.github.io/CitableBase.jl/stable/).   Note that in each function, the first parameter is the passage of text, and the second a URN to compare the text to.

```@example passage
urnequals(everett_psg, everett_urn)
```


```@example passage
urnequals(everett_psg, hay_urn)
```


```@example passage
lincoln_generic = CtsUrn("urn:cts:citedemo:gburg:")
hay_generic = CtsUrn("urn:cts:citedemo:gburg.hay:")
urncontains(hay_psg, lincoln_generic)
```

```@example passage
```
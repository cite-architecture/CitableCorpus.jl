# Citable passages

A `CitablePassage` represents a single canonically citable unit of text. Construct one with a `CtsUrn` and a string value.

```@example passage
using CitableCorpus
using CitableText

psgurn = CtsUrn("urn:cts:citedemo:gburg.bancroft.v2:1")
txt = "Four score and seven years ago our fathers brought forth, on this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal."
psg = CitablePassage(psgurn, txt)
```


Use the `text` function to find the text content of a passage.

```@example passage
text(psg)
```

`CitablePassage`s can be compared used the `==` function of Julia `Base`.

```@example passage
duplicate = psg
psg == duplicate
```




## A citable object

A `CitablePassage` follows `CtsBase`'s definition of a [*citable object*](https://cite-architecture.github.io/CitableBase.jl/stable/citable/).   It therefore must implement three traits defining behavior for *citation*, *comparison based on URN logic*, and *serialization to/from CEX format*.


```@example passage
using CitableBase
citable(psg)
```

```@example passage
urncomparable(psg)
```

```@example passage
cexserializable(psg)
```

### Citation

The `label` and `urn` functions are available from `CitableBase`.

```@example passage
label(psg)
```


```@example passage
urn(psg)
```


Since `CitablePassage`s are cited by `CtsUrn`, you can use any functions from [the `CitableText` package](https://cite-architecture.github.io/CitableText.jl/stable/guide/).

```@example passage
urn(psg) |> passagecomponent
```

## URN comparison


`CitablePassage`s can be compared to URNs using [URN logic for equality, containment and similarity](https://cite-architecture.github.io/CitableBase.jl/stable/). 


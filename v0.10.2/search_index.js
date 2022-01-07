var documenterSearchIndex = {"docs":
[{"location":"api/#API-documentation","page":"API documentation","title":"API documentation","text":"","category":"section"},{"location":"api/#Exported-functions","page":"API documentation","title":"Exported functions","text":"","category":"section"},{"location":"api/#For-a-cataloged-text","page":"API documentation","title":"For a cataloged text","text":"","category":"section"},{"location":"api/","page":"API documentation","title":"API documentation","text":"entry\ncitation\ntextgroup\nwork\nversion\nexemplar\nonline\nlang","category":"page"},{"location":"api/#CitableCorpus.entry","page":"API documentation","title":"CitableCorpus.entry","text":"Construct a CatalogedText allowing for some default values.\n\nentry(u, citation, group, work, version; exemplar, online, lang)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#CitableCorpus.citation","page":"API documentation","title":"CitableCorpus.citation","text":"Retrieve label for citation pattern of txt.\n\ncitation(txt)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#CitableCorpus.textgroup","page":"API documentation","title":"CitableCorpus.textgroup","text":"Retrieve label for text group of txt.\n\ntextgroup(txt)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#CitableCorpus.work","page":"API documentation","title":"CitableCorpus.work","text":"Retrieve label for work of txt.\n\nwork(txt)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#CitableCorpus.version","page":"API documentation","title":"CitableCorpus.version","text":"Retrieve label for version of txt.\n\nversion(txt)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#CitableCorpus.exemplar","page":"API documentation","title":"CitableCorpus.exemplar","text":"Retrieve label for exemplar (if any) of txt.\n\nexemplar(txt)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#CitableCorpus.online","page":"API documentation","title":"CitableCorpus.online","text":"True if txt is online.\n\nonline(txt)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#CitableCorpus.lang","page":"API documentation","title":"CitableCorpus.lang","text":"Retrieve ISO language code for txt.\n\nlang(txt)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#Other","page":"API documentation","title":"Other","text":"","category":"section"},{"location":"api/","page":"API documentation","title":"API documentation","text":"text\ndocument_urns","category":"page"},{"location":"api/#CitableCorpus.text","page":"API documentation","title":"CitableCorpus.text","text":"Text content of psg.\n\ntext(psg)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#CitableCorpus.document_urns","page":"API documentation","title":"CitableCorpus.document_urns","text":"Identify documents in a corpus by URN.\n\ndocument_urns(c)\n\n\n\n\n\n\nIdentify documents in a list of passages by URN.\n\ndocument_urns(v)\n\n\n\n\n\n\n","category":"function"},{"location":"corpora/#Citable-corpora","page":"Citable corpora","title":"Citable corpora","text":"","category":"section"},{"location":"corpora/","page":"Citable corpora","title":"Citable corpora","text":"The CitableTextCorpus is a wrapper around a Vector of CitablePassages.  You can construct one from a Vector CitablePassages.","category":"page"},{"location":"corpora/","page":"Citable corpora","title":"Citable corpora","text":"using CitableCorpus\nusing CitableText\n\nbancroft1 = CtsUrn(\"urn:cts:citedemo:gburg.bancroft.v2:1\")\neverett1 = CtsUrn(\"urn:cts:citedemo:gburg.everett.v2:1\")\npsgs = [\n    CitablePassage(bancroft1, \"Four score and seven years ago our fathers brought forth, on this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal.\"),\n    CitablePassage(everett1, \"Four score and seven years ago our fathers brought forth, upon this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal.\")\n]\ncorpus = CitableTextCorpus(psgs)","category":"page"},{"location":"corpora/","page":"Citable corpora","title":"Citable corpora","text":"The CitableTextCorpus implements the CitableCollectionTrait, and therefore supports URN comparison and CEX serialization.","category":"page"},{"location":"corpora/","page":"Citable corpora","title":"Citable corpora","text":"using CitableBase\ncitablecollection(corpus)","category":"page"},{"location":"corpora/","page":"Citable corpora","title":"Citable corpora","text":"cexserializable(corpus)","category":"page"},{"location":"corpora/","page":"Citable corpora","title":"Citable corpora","text":"urncomparable(corpus)","category":"page"},{"location":"corpora/","page":"Citable corpora","title":"Citable corpora","text":"In addition, it implements Julia's Iterators behavior.","category":"page"},{"location":"corpora/#Urn-comparison-and-filtering","page":"Citable corpora","title":"Urn comparison and filtering","text":"","category":"section"},{"location":"corpora/","page":"Citable corpora","title":"Citable corpora","text":"urnequals(everett1, corpus)","category":"page"},{"location":"corpora/","page":"Citable corpora","title":"Citable corpora","text":"allgburg = CtsUrn(\"urn:cts:citedemo:gburg:\")\nurncontains(allgburg, corpus)","category":"page"},{"location":"corpora/","page":"Citable corpora","title":"Citable corpora","text":"allgburg = CtsUrn(\"urn:cts:citedemo:gburg:\")\nurnsimilar(allgburg, corpus)","category":"page"},{"location":"corpora/#CEX-serialization","page":"Citable corpora","title":"CEX serialization","text":"","category":"section"},{"location":"corpora/","page":"Citable corpora","title":"Citable corpora","text":"corpuscex = cex(corpus)","category":"page"},{"location":"corpora/","page":"Citable corpora","title":"Citable corpora","text":"fromcex(corpuscex, CitableTextCorpus) == corpus","category":"page"},{"location":"corpora/#Iteration","page":"Citable corpora","title":"Iteration","text":"","category":"section"},{"location":"corpora/","page":"Citable corpora","title":"Citable corpora","text":"length(corpus)","category":"page"},{"location":"corpora/","page":"Citable corpora","title":"Citable corpora","text":"eltype(corpus)","category":"page"},{"location":"corpora/","page":"Citable corpora","title":"Citable corpora","text":"collect(corpus)","category":"page"},{"location":"corpora/","page":"Citable corpora","title":"Citable corpora","text":"for psg in corpus\n    println(psg)\nend","category":"page"},{"location":"passages/#Citable-passages","page":"Citable passages","title":"Citable passages","text":"","category":"section"},{"location":"passages/","page":"Citable passages","title":"Citable passages","text":"A CitablePassage represents a single canonically citable unit of text which you construct with a CtsUrn and a string value.  Here we create a CitablePassage for the opening sentence of the Gettysburg Address in the version of John Hay, now in the Library of Congress.","category":"page"},{"location":"passages/","page":"Citable passages","title":"Citable passages","text":"using CitableCorpus\nusing CitableText\n\nhay_urn = CtsUrn(\"urn:cts:citedemo:gburg.hay.v2:1\")\nhay_txt = \"Four score and seven years ago our fathers brought forth, upon this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal.\"\nhay_psg = CitablePassage(hay_urn, hay_txt)","category":"page"},{"location":"passages/","page":"Citable passages","title":"Citable passages","text":"Use the text function to find the text content of a passage.","category":"page"},{"location":"passages/","page":"Citable passages","title":"Citable passages","text":"text(hay_psg)","category":"page"},{"location":"passages/","page":"Citable passages","title":"Citable passages","text":"CitablePassages can be compared used the == function of Julia Base.","category":"page"},{"location":"passages/","page":"Citable passages","title":"Citable passages","text":"duplicate = hay_psg\nhay_psg == duplicate","category":"page"},{"location":"passages/","page":"Citable passages","title":"Citable passages","text":"Note that two passages are equal only if both their text and URNs match.  Here is the opening sentence of Lincoln's address in the version of Edward Everett, the principal speaker at Gettysburg.","category":"page"},{"location":"passages/","page":"Citable passages","title":"Citable passages","text":"everett_urn = CtsUrn(\"urn:cts:citedemo:gburg.everett.v2:1\")\neverett_txt = \"Four score and seven years ago our fathers brought forth, upon this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal.\"\neverett_psg = CitablePassage(everett_urn, everett_txt)","category":"page"},{"location":"passages/","page":"Citable passages","title":"Citable passages","text":"Two different passages may have identical text content.","category":"page"},{"location":"passages/","page":"Citable passages","title":"Citable passages","text":"text(hay_psg) == text(everett_psg)","category":"page"},{"location":"passages/","page":"Citable passages","title":"Citable passages","text":"hay_psg == everett_psg","category":"page"},{"location":"passages/#A-citable-object","page":"Citable passages","title":"A citable object","text":"","category":"section"},{"location":"passages/","page":"Citable passages","title":"Citable passages","text":"A CitablePassage follows CtsBase's definition of a citable object.   It therefore must implement three traits defining behavior for citation, comparison based on URN logic, and serialization to/from CEX format.","category":"page"},{"location":"passages/","page":"Citable passages","title":"Citable passages","text":"using CitableBase\ncitable(everett_psg)","category":"page"},{"location":"passages/","page":"Citable passages","title":"Citable passages","text":"urncomparable(everett_psg)","category":"page"},{"location":"passages/","page":"Citable passages","title":"Citable passages","text":"cexserializable(everett_psg)","category":"page"},{"location":"passages/#Citation","page":"Citable passages","title":"Citation","text":"","category":"section"},{"location":"passages/","page":"Citable passages","title":"Citable passages","text":"The label and urn functions are available from CitableBase.","category":"page"},{"location":"passages/","page":"Citable passages","title":"Citable passages","text":"label(everett_psg)","category":"page"},{"location":"passages/","page":"Citable passages","title":"Citable passages","text":"urn(everett_psg)","category":"page"},{"location":"passages/","page":"Citable passages","title":"Citable passages","text":"Since CitablePassages are cited by CtsUrn, you can use any functions from the CitableText package.","category":"page"},{"location":"passages/","page":"Citable passages","title":"Citable passages","text":"urn(everett_psg) |> passagecomponent","category":"page"},{"location":"passages/#URN-comparison","page":"Citable passages","title":"URN comparison","text":"","category":"section"},{"location":"passages/","page":"Citable passages","title":"Citable passages","text":"CitablePassages can be compared to URNs using URN logic for equality, containment and similarity.   Note that in each function, the first parameter is the passage of text, and the second a URN to compare the text to.","category":"page"},{"location":"passages/","page":"Citable passages","title":"Citable passages","text":"urnequals(everett_psg, everett_urn)","category":"page"},{"location":"passages/","page":"Citable passages","title":"Citable passages","text":"urnequals(everett_psg, hay_urn)","category":"page"},{"location":"passages/","page":"Citable passages","title":"Citable passages","text":"lincoln_generic = CtsUrn(\"urn:cts:citedemo:gburg:\")\nhay_generic = CtsUrn(\"urn:cts:citedemo:gburg.hay:\")\nurncontains(hay_psg, lincoln_generic)","category":"page"},{"location":"passages/","page":"Citable passages","title":"Citable passages","text":"urncontains(everett_psg, lincoln_generic)","category":"page"},{"location":"passages/","page":"Citable passages","title":"Citable passages","text":"urncontains(everett_psg, hay_generic)","category":"page"},{"location":"passages/","page":"Citable passages","title":"Citable passages","text":"urncontains(hay_psg, hay_generic)","category":"page"},{"location":"passages/","page":"Citable passages","title":"Citable passages","text":"urnsimilar(everett_psg, lincoln_generic)","category":"page"},{"location":"passages/#CEX-serialization","page":"Citable passages","title":"CEX serialization","text":"","category":"section"},{"location":"passages/","page":"Citable passages","title":"Citable passages","text":"CitablePassages can be lossly roundtripped to and from objects and delimited-text strings in CEX format using the cex and fromcex functions of CitableBase.","category":"page"},{"location":"passages/","page":"Citable passages","title":"Citable passages","text":"cex(everett_psg)","category":"page"},{"location":"passages/","page":"Citable passages","title":"Citable passages","text":"everett_cex = cex(everett_psg)\neverett_psg == fromcex(everett_cex, CitablePassage)","category":"page"},{"location":"documents/#Citable-documents","page":"Citable documents","title":"Citable documents","text":"","category":"section"},{"location":"documents/","page":"Citable documents","title":"Citable documents","text":"A CitableDocument represents a sequence of canonically citable passages belonging to a single document; that is, a sequence passages with identicial work components to their CtsUrns.  You can construct CitableDocument with a Vector of CitablePassages.  This examples creates a document for John Hay's version of the Gettysburg Address.","category":"page"},{"location":"documents/","page":"Citable documents","title":"Citable documents","text":"using CitableCorpus\nusing CitableText\n\nhay_urn = CtsUrn(\"urn:cts:citedemo:gburg.hay.v2:\")\nhay_title = \"Gettsyburg Address (Hay's version)\"\nhay_passages = [\n    CitablePassage(CtsUrn(\"urn:cts:citedemo:gburg.hay.v2:1\"), \"Four score and seven years ago our fathers brought forth, upon this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal.\"),\n    CitablePassage(CtsUrn(\"urn:cts:citedemo:gburg.hay.v2:2\"), \"Now we are engaged in a great civil war, testing whether that nation, or any nation so conceived, and so dedicated, can long endure. We are met here on a great battlefield of that war. We have come to dedicate a portion of it, as a final resting place for those who here gave their lives that that nation might live. It is altogether fitting and proper that we should do this.\"),\n    CitablePassage(CtsUrn(\"urn:cts:citedemo:gburg.hay.v2:3\"), \"But in a larger sense, we can not dedicate we can not consecrate we can not hallow this ground. The brave men, living and dead, who struggled here, have consecrated it far above our poor power to add or detract. The world will little note, nor long remember, what we say here, but can never forget what they did here.\"),\n    CitablePassage(CtsUrn(\"urn:cts:citedemo:gburg.hay.v2:4\"), \"It is for us, the living, rather to be dedicated here to the unfinished work which they have, thus far, so nobly carried on. It is rather for us to be here dedicated to the great task remaining before us that from these honored dead we take increased devotion to that cause for which they gave the last full measure of devotion that we here highly resolve that these dead shall not have died in vain; that this nation shall have a new birth of freedom; and that this government of the people, by the people, for the people, shall not perish from the earth.\")\n]\n\n#hay = CitableDocument(hay_urn, hay_title, hay_passages)","category":"page"},{"location":"catalogentry/#A-text-catalog-entry","page":"Text catalog entry","title":"A text catalog entry","text":"","category":"section"},{"location":"catalogentry/","page":"Text catalog entry","title":"Text catalog entry","text":"A CatalogedText identifies a concrete version of a text by CTS URN, and records labels for its citation pattern and work hierarchy.  You can create a CatalogedText with the entry function.","category":"page"},{"location":"catalogentry/","page":"Text catalog entry","title":"Text catalog entry","text":"using CitableCorpus\nusing CitableText\n\nhay_urn = CtsUrn(\"urn:cts:citedemo:gburg.hay.v2:\")\ncatentry = entry(hay_urn, \"section\", \"Gettysburg Address\", \"Text of John Hay\", \"second HC digital edition\")","category":"page"},{"location":"catalogentry/","page":"Text catalog entry","title":"Text catalog entry","text":"note: Default values\nNotice that the entry function has supplied default values for the exemplar, online and lang fields.  You can override those defaults with optional parameters.","category":"page"},{"location":"catalogentry/","page":"Text catalog entry","title":"Text catalog entry","text":"Access values of the cataloged entry with these functions:","category":"page"},{"location":"catalogentry/","page":"Text catalog entry","title":"Text catalog entry","text":"citation(catentry)","category":"page"},{"location":"catalogentry/","page":"Text catalog entry","title":"Text catalog entry","text":"textgroup(catentry)","category":"page"},{"location":"catalogentry/","page":"Text catalog entry","title":"Text catalog entry","text":"work(catentry)","category":"page"},{"location":"catalogentry/","page":"Text catalog entry","title":"Text catalog entry","text":"version(catentry)","category":"page"},{"location":"catalogentry/","page":"Text catalog entry","title":"Text catalog entry","text":"exemplar(catentry) |> isnothing","category":"page"},{"location":"catalogentry/","page":"Text catalog entry","title":"Text catalog entry","text":"lang(catentry)","category":"page"},{"location":"catalogentry/#A-citable-object","page":"Text catalog entry","title":"A citable object","text":"","category":"section"},{"location":"catalogentry/","page":"Text catalog entry","title":"Text catalog entry","text":"A CatalogedText follows CtsBase's definition of a citable object.   It therefore implements three traits defining behavior for (1) citation, (2) comparison based on URN logic, and (3) serialization to/from CEX format. You can verify that with the following functions from CitableBase.","category":"page"},{"location":"catalogentry/","page":"Text catalog entry","title":"Text catalog entry","text":"using CitableBase\ncitable(catentry)","category":"page"},{"location":"catalogentry/","page":"Text catalog entry","title":"Text catalog entry","text":"urncomparable(catentry)","category":"page"},{"location":"catalogentry/","page":"Text catalog entry","title":"Text catalog entry","text":"cexserializable(catentry)","category":"page"},{"location":"catalogentry/#Citation","page":"Text catalog entry","title":"Citation","text":"","category":"section"},{"location":"catalogentry/","page":"Text catalog entry","title":"Text catalog entry","text":"The label and urn functions are available for citable objects.","category":"page"},{"location":"catalogentry/","page":"Text catalog entry","title":"Text catalog entry","text":"label(catentry)","category":"page"},{"location":"catalogentry/","page":"Text catalog entry","title":"Text catalog entry","text":"urn(catentry)","category":"page"},{"location":"catalogentry/#URN-comparison","page":"Text catalog entry","title":"URN comparison","text":"","category":"section"},{"location":"catalogentry/","page":"Text catalog entry","title":"Text catalog entry","text":"CatalogedTexts can be compared to URNs using URN logic for equality, containment and similarity.   Note that in each function, the first parameter is the catalog entry, and the second a URN to compare the text to.","category":"page"},{"location":"catalogentry/","page":"Text catalog entry","title":"Text catalog entry","text":"urnequals(catentry, hay_urn)","category":"page"},{"location":"catalogentry/","page":"Text catalog entry","title":"Text catalog entry","text":"allgburg = CtsUrn(\"urn:cts:citedemo:gburg:\")\nurncontains(catentry, allgburg)","category":"page"},{"location":"catalogentry/","page":"Text catalog entry","title":"Text catalog entry","text":"urnsimilar(catentry, allgburg)","category":"page"},{"location":"catalogentry/#CEX-serialization","page":"Text catalog entry","title":"CEX serialization","text":"","category":"section"},{"location":"catalogentry/","page":"Text catalog entry","title":"Text catalog entry","text":"CitablePassages can be lossly roundtripped to and from objects and delimited-text strings in CEX format using the cex and fromcex functions of CitableBase.","category":"page"},{"location":"catalogentry/","page":"Text catalog entry","title":"Text catalog entry","text":"cex(catentry)","category":"page"},{"location":"catalogentry/","page":"Text catalog entry","title":"Text catalog entry","text":"fromcex(cex(catentry), CatalogedText) == catentry","category":"page"},{"location":"catalogcollection/#Text-catalog","page":"Text catalog","title":"Text catalog","text":"","category":"section"},{"location":"catalogcollection/","page":"Text catalog","title":"Text catalog","text":"A TextCatalogCollection is a wrapper around a Vector of CatalogedTexts. You can construct one from a Vector of CatalogedTexts.","category":"page"},{"location":"catalogcollection/","page":"Text catalog","title":"Text catalog","text":"using CitableCorpus\nusing CitableText\n\nhay_urn = CtsUrn(\"urn:cts:citedemo:gburg.hay.v2:\")\nhay = entry(hay_urn, \"section\", \"Gettysburg Address\", \"Text of John Hay\", \"second HC digital edition\")\neverett_urn = CtsUrn(\"urn:cts:citedemo:gburg.everett.v2:\")\neverett = entry(everett_urn, \"section\", \"Gettysburg Address\", \"Text of Edward Everett\", \"second HC digital edition\")\ncatalog = TextCatalogCollection([hay, everett])","category":"page"},{"location":"catalogcollection/","page":"Text catalog","title":"Text catalog","text":"The TextCatalogCollection implements the CitableCollectionTrait, which implies that it also implements URN comparison and CEX serialization","category":"page"},{"location":"catalogcollection/","page":"Text catalog","title":"Text catalog","text":"using CitableBase\ncitablecollection(catalog)","category":"page"},{"location":"catalogcollection/","page":"Text catalog","title":"Text catalog","text":"cexserializable(catalog)","category":"page"},{"location":"catalogcollection/","page":"Text catalog","title":"Text catalog","text":"urncomparable(catalog)","category":"page"},{"location":"catalogcollection/","page":"Text catalog","title":"Text catalog","text":"In addition, it implements Julia's Iterators behavior, as we'll see below.","category":"page"},{"location":"catalogcollection/#Urn-comparison-and-filtering","page":"Text catalog","title":"Urn comparison and filtering","text":"","category":"section"},{"location":"catalogcollection/","page":"Text catalog","title":"Text catalog","text":"urnequals(hay_urn, catalog)","category":"page"},{"location":"catalogcollection/","page":"Text catalog","title":"Text catalog","text":"allgburg = CtsUrn(\"urn:cts:citedemo:gburg:\")\nurncontains(allgburg, catalog)","category":"page"},{"location":"catalogcollection/","page":"Text catalog","title":"Text catalog","text":"urnsimilar(allgburg, catalog)","category":"page"},{"location":"catalogcollection/#CEX-serialization","page":"Text catalog","title":"CEX serialization","text":"","category":"section"},{"location":"catalogcollection/","page":"Text catalog","title":"Text catalog","text":"catcex = cex(catalog)","category":"page"},{"location":"catalogcollection/","page":"Text catalog","title":"Text catalog","text":"fromcex(catcex, TextCatalogCollection) == catalog","category":"page"},{"location":"catalogcollection/#Iteration","page":"Text catalog","title":"Iteration","text":"","category":"section"},{"location":"catalogcollection/","page":"Text catalog","title":"Text catalog","text":"length(catalog)","category":"page"},{"location":"catalogcollection/","page":"Text catalog","title":"Text catalog","text":"eltype(catalog)","category":"page"},{"location":"catalogcollection/","page":"Text catalog","title":"Text catalog","text":"collect(catalog)","category":"page"},{"location":"catalogcollection/","page":"Text catalog","title":"Text catalog","text":"for entry in catalog\n    println(entry)\nend","category":"page"},{"location":"#CitableCorpus.jl","page":"Overview","title":"CitableCorpus.jl","text":"","category":"section"},{"location":"","page":"Overview","title":"Overview","text":"The CitableCorpus.jl package defines functions for working with the following structures:","category":"page"},{"location":"","page":"Overview","title":"Overview","text":"a CatalogedText text associates labelling metadata with an identifying URN for a concrete version of a text.\na TextCatalogCollection is a collection of CatalogedTexts.\na CitablePassage represents a passage of text.  It associates a CtsUrn with a string value for the content of the passage.\na CitableTextCorpus contains an ordered list of CitablePassages belonging to one or more versions of one or more texts.","category":"page"},{"location":"","page":"Overview","title":"Overview","text":"note: In development\nThe next release of CitableCorpus is planned to include CitableDocument and CitableDocumentCollection types. The CitableDocument represents a single cataloged document. It associates an ordered list of CitablePassages, all belonging to a single version of a single text, with a CatalogedText.  The CitableDocumentCollection is list of CitableDocuments.","category":"page"},{"location":"","page":"Overview","title":"Overview","text":"The behaviors of these structures are defined by the traits from the CitableBase package that each one fulfills.","category":"page"},{"location":"","page":"Overview","title":"Overview","text":"Both the TextCatalogCollection and the CitableTextCorpus are citable collections, and therefore implement Julia's interface for iterators. This means that you can apply any function to them that you can use for other iterable collections.  for psg in corpus, for example, iterates through all passages in corpus.","category":"page"},{"location":"#User's-guide","page":"Overview","title":"User's guide","text":"","category":"section"},{"location":"","page":"Overview","title":"Overview","text":"The following pages document each of the above structures. Throughout our examples, we will work with a citable corpus of the five extant versions of the Gettysburg Address. ","category":"page"},{"location":"","page":"Overview","title":"Overview","text":"tip: Data files\nYou can find the text corpus serialized in CEX format in the file gettysburgcorpus.cex of this repository's test/data directory. In the same directory, the file gettysburgcatalog.cex has a CEX representation of the catalog for that corpus.","category":"page"}]
}

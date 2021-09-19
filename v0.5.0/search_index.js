var documenterSearchIndex = {"docs":
[{"location":"api/#API-documentation","page":"API documentation","title":"API documentation","text":"","category":"section"},{"location":"api/#Exported-types-and-functions","page":"API documentation","title":"Exported types and functions","text":"","category":"section"},{"location":"api/#The-main-types","page":"API documentation","title":"The main types","text":"","category":"section"},{"location":"api/","page":"API documentation","title":"API documentation","text":"CitablePassage\nCitableTextCorpus\nCatalogedText","category":"page"},{"location":"api/#CitableCorpus.CitablePassage","page":"API documentation","title":"CitableCorpus.CitablePassage","text":"A canonically citable text node.\n\n\n\n\n\n","category":"type"},{"location":"api/#CitableCorpus.CitableTextCorpus","page":"API documentation","title":"CitableCorpus.CitableTextCorpus","text":"A canonically citable text corpus.\n\n\n\n\n\n","category":"type"},{"location":"api/#CitableCorpus.CatalogedText","page":"API documentation","title":"CitableCorpus.CatalogedText","text":"A catalog description of a text.\n\n\n\n\n\n","category":"type"},{"location":"api/#Building-a-corpus","page":"API documentation","title":"Building a corpus","text":"","category":"section"},{"location":"api/","page":"API documentation","title":"API documentation","text":"combine\ntextdf","category":"page"},{"location":"api/#CitableCorpus.combine","page":"API documentation","title":"CitableCorpus.combine","text":"combine(c1, c2)\n\n\nCreate a single composite CitableTextCorpus` from two sources.\n\n\n\n\n\ncombine(src_array)\ncombine(src_array, composite)\n\n\nCreate a single composite CitableTextCorpus` from an array of source corpora by recursively adding corpora.\n\n\n\n\n\n","category":"function"},{"location":"api/#CitableCorpus.textdf","page":"API documentation","title":"CitableCorpus.textdf","text":"Create a DataFrame of passages in doc.\n\ntextdf(doc)\n\n\n\n\n\n\ntextdf(c)\n\n\nCreate a DataFrame from a CitableTextCorpus\n\n\n\n\n\n","category":"function"},{"location":"api/#Navigating-a-corpus","page":"API documentation","title":"Navigating a corpus","text":"","category":"section"},{"location":"api/","page":"API documentation","title":"API documentation","text":"next\nprev\nretrieve","category":"page"},{"location":"api/#CitableCorpus.next","page":"API documentation","title":"CitableCorpus.next","text":"Find the next CitablePassage after u in a corpus. If no passage found, or u is last passage in corpus, return nothing.\n\nnext(u, c)\n\n\n\n\n\n\nFind the next CitablePassage after u in a document. If no passage found, or u is last passage in document, return nothing.\n\nnext(u, doc)\n\n\n\n\n\n\nFind the next CitablePassage after u in a DataFrame. If no passage found, or u is last passage in DataFrame, return nothing.\n\nnext(u, psgdf)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#CitableCorpus.prev","page":"API documentation","title":"CitableCorpus.prev","text":"Find the previous CitablePassage before u in a corpus. If no passage found, or u is the first passage in the corpus, return nothing.\n\nprev(u, c)\n\n\n\n\n\n\nFind the previous CitablePassage before u in a document. If no passage found, or u is the first passage in the document, return nothing.\n\nprev(u, doc)\n\n\n\n\n\n\nFind the previous CitablePassage before u in a DataFrame. If no passage found, or u is the first passage in the DataFrame, return nothing.\n\nprev(u, psgdf)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#CitableCorpus.retrieve","page":"API documentation","title":"CitableCorpus.retrieve","text":"Retrieve citable passages identified by u from a corpus. Returns a (possibly empty) Vector of CitablePassages.\n\nretrieve(u, c)\n\n\n\n\n\n\nRetrieve citable passages identified by u from a document. Returns a (possibly empty) Vector of CitablePassages.\n\nretrieve(u, doc)\n\n\n\n\n\n\nRetrieve citable passages identified by u from a DataFrame of  citable passages. Returns a (possibly empty) Vector of CitablePassages.\n\nretrieve(u, psgdf)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#Reading-the-catalog-of-a-corpus","page":"API documentation","title":"Reading the catalog of a corpus","text":"","category":"section"},{"location":"api/","page":"API documentation","title":"API documentation","text":"groupname\nworktitle\nversionlabel\nexemplarlabel\ncitationlabels\nonline\nlang","category":"page"},{"location":"api/#CitableCorpus.groupname","page":"API documentation","title":"CitableCorpus.groupname","text":"Read text group name for a given text. Returns nothing if no entry found\n\ngroupname(catalogdf, urn)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#CitableCorpus.worktitle","page":"API documentation","title":"CitableCorpus.worktitle","text":"Read work title for a given text. Returns nothing if no entry found\n\nworktitle(catalogdf, urn)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#CitableCorpus.versionlabel","page":"API documentation","title":"CitableCorpus.versionlabel","text":"Read version label for a given text. Returns nothing if no entry found\n\nversionlabel(catalogdf, urn)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#CitableCorpus.exemplarlabel","page":"API documentation","title":"CitableCorpus.exemplarlabel","text":"Read exemplar label for a given text. Returns nothing if no entry found\n\nexemplarlabel(catalogdf, urn)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#CitableCorpus.citationlabels","page":"API documentation","title":"CitableCorpus.citationlabels","text":"Read citable labels for a given text. Returns nothing if no entry found, otherwise returns a comma-delimited list of labels for each level of the citation hierarchy.\n\ncitationlabels(catalogdf, urn)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#CitableCorpus.online","page":"API documentation","title":"CitableCorpus.online","text":"True if text identified by urn is online.\n\nonline(catalogdf, urn)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#CitableCorpus.lang","page":"API documentation","title":"CitableCorpus.lang","text":"Read ISO language code for urn from catalog. Returns nothing if no entry found.\n\nlang(catalogdf, urn)\n\n\n\n\n\n\n","category":"function"},{"location":"catalog/#Citable-Text-Catalogs","page":"Citable text catalogs","title":"Citable Text Catalogs","text":"","category":"section"},{"location":"catalog/#A-single-catalog-entry","page":"Citable text catalogs","title":"A single catalog entry","text":"","category":"section"},{"location":"catalog/","page":"Citable text catalogs","title":"Citable text catalogs","text":"A CatalogedText has the following information about an individual text:","category":"page"},{"location":"catalog/","page":"Citable text catalogs","title":"Citable text catalogs","text":"its URN\nits citation scheme, expressed as a comma-delimited string labeling each tier of the hierarchy.  In the example here, the citation scheme has two levels labeled \"chapter\" and \"section\".\nA text group\nA work title\nA version identifier\nAn exemplar (here, empty)\nWhether the text is online\nThe languagej of the text, identified by 3-letter ISO code.","category":"page"},{"location":"catalog/","page":"Citable text catalogs","title":"Citable text catalogs","text":"using CitableCorpus\ndata = \"urn:cts:latinLit:stoa1263.stoa001.hc:|chapter,section|Hyginus|Fabulae|Holy Cross edition||true|lat\"\ncolumns = split(data, \"|\")\ncataloged = catalog(columns)\ncataloged.group\n\n# output\n\n\"Hyginus\"","category":"page"},{"location":"catalog/#A-collection-of-cataloged-texts","page":"Citable text catalogs","title":"A collection of cataloged texts","text":"","category":"section"},{"location":"catalog/","page":"Citable text catalogs","title":"Citable text catalogs","text":"You can create either Vectors of CatalogedTexts or DataFrames with catalog data from delimited-text sources.","category":"page"},{"location":"catalog/","page":"Citable text catalogs","title":"Citable text catalogs","text":"catalog_fromdelimited\ndffromfile, dffromurl\nfromcexfile, fromcexurl","category":"page"},{"location":"#CitableCorpus.jl","page":"Overview","title":"CitableCorpus.jl","text":"","category":"section"},{"location":"","page":"Overview","title":"Overview","text":"The CitableCorpus.jl package defines functions for working with:  ","category":"page"},{"location":"","page":"Overview","title":"Overview","text":"a CitablePassage represents a passage of text.  It associates a CtsUrn with a string value for the content of the passage.\na CitableTextCorpus contains an ordered list of CitablePassages.\na CatalogedText contains catalog information for a single citable text document.","category":"page"},{"location":"corpus/#Citable-passages,-documents-and-corpora","page":"Citable passages and corpora","title":"Citable passages, documents and corpora","text":"","category":"section"},{"location":"corpus/#Citable-passages","page":"Citable passages and corpora","title":"Citable passages","text":"","category":"section"},{"location":"corpus/","page":"Citable passages and corpora","title":"Citable passages and corpora","text":"A CitablePassage has two members: a URN, and a string of text.  You can apply all of the CitableText module's functions for working with URNs to the CitablePassage's URN.","category":"page"},{"location":"corpus/","page":"Citable passages and corpora","title":"Citable passages and corpora","text":"using CitableCorpus\nusing CitableText\n\npsgurn = CtsUrn(\"urn:cts:citedemo:gburg.bancroft.v2:1\")\ntxt = \"Four score and seven years ago our fathers brought forth, on this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal.\"\npsg = CitablePassage(psgurn, txt)\nurn(psg) |> passagecomponent\n\n# output\n\n\"1\"","category":"page"},{"location":"corpus/","page":"Citable passages and corpora","title":"Citable passages and corpora","text":"psg.text\n\n# output\n\n\"Four score and seven years ago our fathers brought forth, on this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal.\"","category":"page"},{"location":"corpus/#Citable-documents","page":"Citable passages and corpora","title":"Citable documents","text":"","category":"section"},{"location":"corpus/","page":"Citable passages and corpora","title":"Citable passages and corpora","text":"A CitableDocument has a title, a CtsUrn, and a Vector of CitablePassages.  Here we'll manually create a very short document with just the first passage of Bancroft's text of the Gettysburg Address.","category":"page"},{"location":"corpus/","page":"Citable passages and corpora","title":"Citable passages and corpora","text":"bancroft = droppassage(psgurn)\ndoc = CitableDocument(bancroft, \"Bancroft's text of the Gettysburg Address\", [psg])\n\n# output\n\nCitableDocument(urn:cts:citedemo:gburg.bancroft.v2:, \"Bancroft's text of the Gettysburg Address\", CitablePassage[CitablePassage(urn:cts:citedemo:gburg.bancroft.v2:1, \"Four score and seven years ago our fathers brought forth, on this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal.\")])","category":"page"},{"location":"corpus/","page":"Citable passages and corpora","title":"Citable passages and corpora","text":"CitableCorpus includes functions that fulfill the contract of the Citable abstraction in the CitableBase module. ","category":"page"},{"location":"corpus/","page":"Citable passages and corpora","title":"Citable passages and corpora","text":"label(doc)\n\n# output\n\n\"Bancroft's text of the Gettysburg Address\"","category":"page"},{"location":"corpus/","page":"Citable passages and corpora","title":"Citable passages and corpora","text":"urn(doc)\n\n# output\n\nurn:cts:citedemo:gburg.bancroft.v2:","category":"page"},{"location":"corpus/#Citable-text-corpus","page":"Citable passages and corpora","title":"Citable text corpus","text":"","category":"section"},{"location":"corpus/","page":"Citable passages and corpora","title":"Citable passages and corpora","text":"A CitableCorpus has a sequence of CitablePassages. ","category":"page"},{"location":"corpus/#I/O-with-documents-and-corpora","page":"Citable passages and corpora","title":"I/O with documents and corpora","text":"","category":"section"},{"location":"corpus/","page":"Citable passages and corpora","title":"Citable passages and corpora","text":"The text_fromcex and corpus_fromcex functions read ctsdata sections from a string formatted in CITE Data Exchange (CEX) format.","category":"page"},{"location":"corpus/","page":"Citable passages and corpora","title":"Citable passages and corpora","text":"cexsrc = join([\n    \"#!ctsdata\",\n    \"// Bancroft's text of the Gettysburg Address, urn:cts:citedemo:gburg.bancroft.v2:\",\n    \"// 1 citable passages.\",\n    \"//\",\n    \"urn:cts:citedemo:gburg.bancroft.v2:1|Four score and seven years ago our fathers brought forth, on this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal.\"], \"\\n\")\ndocument_fromcex(cexsrc)    \n\n# output\n\nCitableDocument(urn:cts:citedemo:gburg.bancroft.v2:, \"Citable document\", Any[CitablePassage(urn:cts:citedemo:gburg.bancroft.v2:1, \"Four score and seven years ago our fathers brought forth, on this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal.\")])","category":"page"},{"location":"corpus/","page":"Citable passages and corpora","title":"Citable passages and corpora","text":"You can use these functions together with normal Julia I/O functions to read CEX data from files, URLs, or other data sources.","category":"page"},{"location":"corpus/","page":"Citable passages and corpora","title":"Citable passages and corpora","text":"f = \"data/gettysburgcorpus.cex\"\ngburgcorpus = read(f, String) |> corpus_fromcex\ngburgcorpus.passages |> length\n\n# output\n\n20","category":"page"},{"location":"corpus/","page":"Citable passages and corpora","title":"Citable passages and corpora","text":"\nbancroftdoc = document_fromcex(read(f, String), docurn=bancroft, title=\"Bancroft's text of the Gettysburg address\")\nbancroftdoc.passages |> length\n\n# output\n\n4","category":"page"},{"location":"corpus/#Navigating-documents-and-corpora","page":"Citable passages and corpora","title":"Navigating documents and corpora","text":"","category":"section"},{"location":"corpus/","page":"Citable passages and corpora","title":"Citable passages and corpora","text":"TBA","category":"page"}]
}

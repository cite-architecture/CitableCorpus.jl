
@testset "Construct citable document" begin
    u = CtsUrn("urn:cts:greekLit:tlg0012.tlg001:1.1")
    content = "μῆνιν ἄειδε, θεά, Πηληϊάδεω Ἀχιλῆος"
    psg = CitablePassage(u,content)
    docurn = droppassage(u)
    doc = CitableDocument(u,"Iliad",[psg])



    @test length(doc.passages) == 1
    @test doc.title == "Iliad" 
    @test doc.urn == u
end


@testset "Test functions required for Citable interface on CitableDocument" begin
    u = CtsUrn("urn:cts:greekLit:tlg0012.tlg001:1.1")
    content = "μῆνιν ἄειδε, θεά, Πηληϊάδεω Ἀχιλῆος"
    psg = CitablePassage(u,content)   
    docurn = droppassage(u)
    doc = CitableDocument(docurn,"Iliad",[psg])



    @test label(doc) == "Iliad"
    @test urn(doc) == docurn

    expectedlines = ["#!ctsdata",
    "// Iliad, urn:cts:greekLit:tlg0012.tlg001:",
    "// 1 citable passages.",
    "//",
    "urn:cts:greekLit:tlg0012.tlg001:1.1|μῆνιν ἄειδε, θεά, Πηληϊάδεω Ἀχιλῆος"
    ]
    @test cex(doc) == join(expectedlines, "\n")
end


@testset "Test CEX parsing for CitableDocument" begin
    iliad = CtsUrn("urn:cts:greekLit:tlg0012.tlg001:")
    
    u = CtsUrn("urn:cts:greekLit:tlg0012.tlg001:1.1")
    content = "μῆνιν ἄειδε, θεά, Πηληϊάδεω Ἀχιλῆος"
    psg = CitablePassage(u,content)   
    docurn = droppassage(u)
    srcdoc1 = CitableDocument(docurn,"Iliad",[psg])
    ctsblock = cex(srcdoc1)

    doc1 = CitableCorpus.document_fromcex(ctsblock)
    @test label(doc1) == "Unlabelled citable document"
    @test urn(doc1) == iliad
    @test length(doc1.passages) == 1

    doc2 = CitableCorpus.document_fromcex(ctsblock; delimiter = "|")
    @test label(doc2) == "Unlabelled citable document"
    @test urn(doc2) == iliad
    @test length(doc2.passages) == 1

    doc3 = CitableCorpus.document_fromcex(ctsblock, title = "Iliad")
    @test label(doc3) == "Iliad" 
    @test urn(doc3) ==  iliad
    @test length(doc3.passages) == 1

    doc4 = CitableCorpus.document_fromcex(ctsblock, title = "Iliad", docurn = iliad)
    @test label(doc4) == "Iliad"
    @test urn(doc4) == iliad
    @test length(doc4.passages) == 1

    bk1 = CtsUrn("urn:cts:greekLit:tlg0012.tlg001:1")
    doc5 =  CitableCorpus.document_fromcex(ctsblock, title = "Iliad, book 1", docurn = bk1)
    @test label(doc5) == "Iliad, book 1"
    @test urn(doc5) == bk1
    @test length(doc5.passages) == 1

    bk2 = CtsUrn("urn:cts:greekLit:tlg0012.tlg001:2")
    @test_throws ArgumentError CitableCorpus.document_fromcex(ctsblock, docurn = bk2)

    odyssey = CtsUrn("urn:cts:greekLit:tlg0012.tlg002:")
    @test_throws ArgumentError CitableCorpus.document_fromcex(ctsblock, docurn = odyssey)
end

@testset "Test reading CEX with multiple documents" begin
    f = joinpath(dirname(pwd()), "docs", "data", "gettysburgcorpus.cex")
    cexsrc = read(f, String)
    @test_throws DomainError document_fromcex(cexsrc)
end
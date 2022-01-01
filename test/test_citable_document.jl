
@testset "Test structure of citable document" begin
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

    @test citable(doc)

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

    doc1 =  nothing # fromcex(ctsblock, CitableDocument)
    @test_broken label(doc1) == "Unlabelled citable document"
    @test_broken urn(doc1) == iliad
    @test_broken length(doc1.passages) == 1

    doc2 = nothing # fromcex(ctsblock, CitableDocument; delimiter = "|")
    @test_broken label(doc2) == "Unlabelled citable document"
    @test_broken urn(doc2) == iliad
    @test_broken length(doc2.passages) == 1

    doc3 = nothing # fromcex(ctsblock, CitableDocument; title = "Iliad")
    @test_broken label(doc3) == "Iliad" 
    @test_broken urn(doc3) ==  iliad
    @test_broken length(doc3.passages) == 1

    doc4 = nothing #fromcex(ctsblock, CitableDocument; title = "Iliad", docurn = iliad)
    @test_broken label(doc4) == "Iliad"
    @test_broken urn(doc4) == iliad
    @test_broken length(doc4.passages) == 1

    bk1 = CtsUrn("urn:cts:greekLit:tlg0012.tlg001:1")
    doc5 =  nothing #fromcex(ctsblock, CitableDocument; title = "Iliad, book 1", docurn = bk1)
    @test_broken label(doc5) == "Iliad, book 1"
    @test_broken urn(doc5) == bk1
    @test_broken length(doc5.passages) == 1

    bk2 = CtsUrn("urn:cts:greekLit:tlg0012.tlg001:2")
    @test_throws ArgumentError fromcex(ctsblock, CitableDocument; docurn = bk2)

    odyssey = CtsUrn("urn:cts:greekLit:tlg0012.tlg002:")
    @test_throws ArgumentError fromcex(ctsblock, CitableDocument; docurn = odyssey)
end

@testset "Test reading CEX with multiple documents" begin
    f = joinpath(dirname(pwd()), "docs", "data", "gettysburgcorpus.cex")
    cexsrc = read(f, String)
    #@test_throws DomainError fromcex(cexsrc, CitableDocument)
end
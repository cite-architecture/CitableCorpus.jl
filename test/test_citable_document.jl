
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
    u = CtsUrn("urn:cts:greekLit:tlg0012.tlg001:1.1")
    content = "μῆνιν ἄειδε, θεά, Πηληϊάδεω Ἀχιλῆος"
    psg = CitablePassage(u,content)   
    docurn = droppassage(u)
    doc = CitableDocument(docurn,"Iliad",[psg])
    inputdata = cex(doc)

    @test_broken 1 == 2
end
@testset "Test simple retrieval from dataframe" begin
    f = joinpath(dirname(pwd()), "docs", "data", "gettysburgcorpus.cex")
    corpus = fromcex(read(f, String), CitableTextCorpus)
    psgurn = CtsUrn("urn:cts:citedemo:gburg.bancroft.v2:3")
    psglist = select(psgurn, corpus)
    @test length(psglist) == 1

    speechurn = CtsUrn("urn:cts:citedemo:gburg.bancroft.v2:")
    speech = select(speechurn, corpus.passages)
    @test length(speech) == 4
end




@testset "Test retrieving a range" begin
    f = joinpath(dirname(pwd()), "docs", "data", "gettysburgcorpus.cex")
    corpus = fromcex(read(f, String), CitableTextCorpus)
    
    rng = CtsUrn("urn:cts:citedemo:gburg.hay.v2:1-4")
    psgs = select(rng, corpus)
    @test length(psgs) == 4
end

@testset "Test retrieving content by URN from high-order structures" begin
    f = joinpath(dirname(pwd()), "docs", "data", "gettysburgcorpus.cex")
    cexsrc = read(f, String)
    corpus =  fromcex(cexsrc, CitableTextCorpus)

    psgurn = CtsUrn("urn:cts:citedemo:gburg.hay.v2:1")
    passage = select(psgurn, corpus)
    @test length(passage) == 1

    rngurn = CtsUrn("urn:cts:citedemo:gburg.hay.v2:1-3")
    range = select(rngurn, corpus)
    @test length(range) == 3

    speechurn = CtsUrn("urn:cts:citedemo:gburg.hay.v2:")
    speech = select(speechurn, corpus)
    @test length(speech) == 4


    #=
    doc = fromcex(cexsrc, CitableDocument; docurn = speechurn)
    @test length(doc.passages) == 4
    docpassage = select(psgurn, doc)
    @test length(docpassage) == 1
    docrange = select(rngurn, doc)
    @test length(docrange) == 3
    # Tautology:
    @test length(doc.passages) == length(select(speechurn, doc))
    =#
end

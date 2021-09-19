@testset "Test simple retrieval from dataframe" begin
    f = joinpath(dirname(pwd()), "docs", "data", "gettysburgcorpus.cex")
    corpus = read(f, String) |> corpus_fromcex
    psgurn = CtsUrn("urn:cts:citedemo:gburg.bancroft.v2:3")
    psglist = CitableCorpus.retrieve_simple(psgurn, DataFrame(corpus.passages))
    @test length(psglist) == 1

    speechurn = CtsUrn("urn:cts:citedemo:gburg.bancroft.v2:")
    speech = CitableCorpus.retrieve_simple(speechurn, DataFrame(corpus.passages))
    @test length(speech) == 4
end

@testset "Test indexing in dataframe" begin
    f = joinpath(dirname(pwd()), "docs", "data", "gettysburgcorpus.cex")
    corpus = read(f, String) |> corpus_fromcex
    df = DataFrame(corpus.passages)
    psgurn = CtsUrn("urn:cts:citedemo:gburg.hay.v2:1")
    @test CitableCorpus.row_indices(psgurn, df) == [13]
    speechurn =  CtsUrn("urn:cts:citedemo:gburg.hay.v2:")
    @test CitableCorpus.row_indices(speechurn, df) == [13, 14, 15, 16]
end


@testset "Test retrieving a range" begin
    f = joinpath(dirname(pwd()), "docs", "data", "gettysburgcorpus.cex")
    corpus = read(f, String) |> corpus_fromcex
    df = DataFrame(corpus.passages)
    rng = CtsUrn("urn:cts:citedemo:gburg.hay.v2:1-4")
    psgs = CitableCorpus.retrieve_range(rng, df)
    @test length(psgs) == 4
end

@testset "Test retrieving content by URN from high-order structures" begin
    f = joinpath(dirname(pwd()), "docs", "data", "gettysburgcorpus.cex")
    cexsrc = read(f, String)
    corpus =  corpus_fromcex(cexsrc)

    psgurn = CtsUrn("urn:cts:citedemo:gburg.hay.v2:1")
    passage = retrieve(psgurn, corpus)
    @test length(passage) == 1

    rngurn = CtsUrn("urn:cts:citedemo:gburg.hay.v2:1-3")
    range = retrieve(rngurn, corpus)
    @test length(range) == 3

    speechurn = CtsUrn("urn:cts:citedemo:gburg.hay.v2:")
    speech = retrieve(speechurn, corpus)
    @test length(speech) == 4


    
    doc = document_fromcex(cexsrc, docurn = speechurn)
    @test length(doc.passages) == 4
    docpassage = retrieve(psgurn, doc)
    @test length(docpassage) == 1
    docrange = retrieve(rngurn, doc)
    @test length(docrange) == 3
    # Tautology:
    @test length(doc.passages) == length(retrieve(speechurn, doc))
end
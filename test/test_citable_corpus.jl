
@testset "Test internal structure of CitableTextCorpus" begin
    psgs = [
        CitablePassage(CtsUrn("urn:cts:citedemo:gburg.bancroft.v2:1"), "Four score and seven years ago our fathers brought forth, on this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal."),
        CitablePassage(CtsUrn("urn:cts:citedemo:gburg.everett.v2:1"), "Four score and seven years ago our fathers brought forth, upon this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal.")
    ]
    corpus = CitableTextCorpus(psgs)
    @test corpus isa CitableTextCorpus

    @test citablecollection(corpus)
    @test citablecollectiontrait(typeof(corpus)) == CitableCorpusTrait()
    expecteddocs = [
        CtsUrn("urn:cts:citedemo:gburg.bancroft.v2:"),
        CtsUrn("urn:cts:citedemo:gburg.everett.v2:")
    ]
    @test document_urns(corpus) == expecteddocs
    
 
end

@testset "Test URN cex serialization on CitableTextCorpus" begin

end

@testset "Test URN comparison on CitableTextCorpus" begin
    psgs = [
        CitablePassage(CtsUrn("urn:cts:citedemo:gburg.bancroft.v2:1"), "Four score and seven years ago our fathers brought forth, on this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal."),
        CitablePassage(CtsUrn("urn:cts:citedemo:gburg.everett.v2:1"), "Four score and seven years ago our fathers brought forth, upon this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal.")
    ]
    corpus = CitableTextCorpus(psgs)

    @test length(urnequals(psgs[1].urn, corpus)) == 1
    @test length(urncontains(psgs[1].urn, corpus)) == 1
    @test length(urnsimilar(psgs[1].urn, corpus)) == 1
    
    everett = CtsUrn("urn:cts:citedemo:gburg.everett.v2:")
    @test length(urnequals(everett, corpus)) == 0
    @test length(urncontains(everett, corpus)) == 1
    @test length(urnsimilar(everett, corpus)) == 1

    gburg = CtsUrn("urn:cts:citedemo:gburg:")
    @test length(urnequals(gburg, corpus)) == 0
    @test length(urncontains(gburg, corpus)) == 2
    @test length(urnsimilar(gburg, corpus)) == 2
end


@testset "Test iteration on CitableTextCorpus" begin
    
end
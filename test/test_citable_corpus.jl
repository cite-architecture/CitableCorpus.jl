
@testset "Test internal structure of CitableTextCorpus" begin
    psgs = [
        CitablePassage(CtsUrn("urn:cts:citedemo:gburg.bancroft.v2:1"), "Four score and seven years ago our fathers brought forth, on this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal."),
        CitablePassage(CtsUrn("urn:cts:citedemo:gburg.everett.v2:1"), "Four score and seven years ago our fathers brought forth, upon this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal.")
    ]
    corpus = CitableTextCorpus(psgs)
    @test corpus isa CitableTextCorpus

    @test citablecollection(corpus)
    @test citablecollectiontrait(typeof(corpus)) == CitableCorpusTrait()
end

@testset "Test URN cex serialization on CitableTextCorpus" begin

end

@testset "Test URN comparison on CitableTextCorpus" begin

end

@testset "Test collection trait on CitableTextCorpus" begin
end

@testset "Test iteration on CitableTextCorpus" begin
    
end
@testset "Test structure of catalog entry" begin
    catentry = entry(CtsUrn("urn:cts:citedemo:gburg.hay.v2:"), "section", "Gettysburg Address", "Text of John Hay", "second HC digital edition")
    @test catentry isa CatalogedText
    @test citation(catentry) == "section"
    @test textgroup(catentry) == "Gettysburg Address"
    @test work(catentry) == "Text of John Hay"
    @test version(catentry) == "second HC digital edition"
    @test isnothing(catentry |> exemplar)
    @test lang(catentry) == "eng"
end


@testset "Test citable status of CatalogedText" begin
    catentry = entry(CtsUrn("urn:cts:citedemo:gburg.hay.v2:"), "section", "Gettysburg Address", "Text of John Hay", "second HC digital edition")
    @test citable(catentry)
    @test urn(catentry) == CtsUrn("urn:cts:citedemo:gburg.hay.v2:")
    @test label(catentry) == "<urn:cts:citedemo:gburg.hay.v2:> Gettysburg Address, Text of John Hay, second HC digital edition"
end
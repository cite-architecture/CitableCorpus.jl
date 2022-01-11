@testset "Test structure of catalog entry" begin
    catentry = entry(CtsUrn("urn:cts:citedemo:gburg.hay.v2:"), "section", "Gettysburg Address", "Text of John Hay", "second HC digital edition")
    @test catentry isa CatalogedText
    @test citation(catentry) == "section"
    @test citationdepth(catentry) == 1
    @test textgroup(catentry) == "Gettysburg Address"
    @test work(catentry) == "Text of John Hay"
    @test version(catentry) == "second HC digital edition"
    @test isnothing(catentry |> exemplar)
    @test lang(catentry) == "eng"
    @test urntype(catentry) == CtsUrn

end


@testset "Test citable status of CatalogedText" begin
    catentry = entry(CtsUrn("urn:cts:citedemo:gburg.hay.v2:"), "section", "Gettysburg Address", "Text of John Hay", "second HC digital edition")
    @test citable(catentry)
    @test citabletrait(typeof(catentry)) == CitableTextEntry()
    @test urn(catentry) == CtsUrn("urn:cts:citedemo:gburg.hay.v2:")
    @test label(catentry) == "<urn:cts:citedemo:gburg.hay.v2:> Gettysburg Address, Text of John Hay, second HC digital edition"
end


@testset "Test URN comparison of CatalogedText" begin
    catentry = entry(CtsUrn("urn:cts:citedemo:gburg.hay.v2:"), "section", "Gettysburg Address", "Text of John Hay", "second HC digital edition")
    allgburg = CtsUrn("urn:cts:citedemo:gburg:")
    
    @test urnequals(catentry, catentry.urn)
    @test urncontains(catentry, allgburg)
    @test urnsimilar(catentry, allgburg)


end

@testset "Test CEX serialization of CatalogedText" begin
    catentry = entry(CtsUrn("urn:cts:citedemo:gburg.hay.v2:"), "section", "Gettysburg Address", "Text of John Hay", "second HC digital edition")
    catentry = entry(CtsUrn("urn:cts:citedemo:gburg.hay.v2:"), "section", "Gettysburg Address", "Text of John Hay", "second HC digital edition")

    expectedcex = "urn:cts:citedemo:gburg.hay.v2:|section|Gettysburg Address|Text of John Hay|second HC digital edition|nothing|true|eng"
    @test  cex(catentry) == expectedcex
    @test fromcex(expectedcex, CatalogedText) == catentry
end
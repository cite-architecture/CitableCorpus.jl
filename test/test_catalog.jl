
@testset "Test structure of TextCatalogCollection" begin
    hay = entry(CtsUrn("urn:cts:citedemo:gburg.hay.v2:"), "section", "Gettysburg Address", "Text of John Hay", "second HC digital edition")
    everett = entry(CtsUrn("urn:cts:citedemo:gburg.everett.v2:"), "section", "Gettysburg Address", "Text of Edward Everett", "second HC digital edition")
    catalog = TextCatalogCollection([hay, everett])

    @test citablecollection(catalog)
    @test citablecollectiontrait(typeof(catalog)) == CitableTextCatalog()

end


@testset "Test URN filtering on TextCatalogCollection" begin
    hay = entry(CtsUrn("urn:cts:citedemo:gburg.hay.v2:"), "section", "Gettysburg Address", "Text of John Hay", "second HC digital edition")
    everett = entry(CtsUrn("urn:cts:citedemo:gburg.everett.v2:"), "section", "Gettysburg Address", "Text of Edward Everett", "second HC digital edition")
    catalog = TextCatalogCollection([hay, everett])

    allgburg = CtsUrn("urn:cts:citedemo:gburg:")

    @test length(urnequals(hay.urn, catalog)) == 1
    @test length(urncontains(allgburg, catalog)) == 2
    @test length(urnsimilar(allgburg, catalog)) == 2
end
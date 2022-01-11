
@testset "Test structure of TextCatalogCollection" begin
    hay = entry(CtsUrn("urn:cts:citedemo:gburg.hay.v2:"), "section", "Gettysburg Address", "Text of John Hay", "second HC digital edition")
    everett = entry(CtsUrn("urn:cts:citedemo:gburg.everett.v2:"), "section", "Gettysburg Address", "Text of Edward Everett", "second HC digital edition")
    catalog = TextCatalogCollection([hay, everett])

    @test citablecollection(catalog)
    @test citablecollectiontrait(typeof(catalog)) == CitableTextCatalog()
    @test urntype(catalog) == CtsUrn
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


@testset "Test CEX serialization for TextCatalogCollection" begin
    hay = entry(CtsUrn("urn:cts:citedemo:gburg.hay.v2:"), "section", "Gettysburg Address", "Text of John Hay", "second HC digital edition")
    everett = entry(CtsUrn("urn:cts:citedemo:gburg.everett.v2:"), "section", "Gettysburg Address", "Text of Edward Everett", "second HC digital edition")
    catalog = TextCatalogCollection([hay, everett])

    expectedcex = "#!ctscatalog\nurn|citationScheme|groupName|workTitle|versionLabel|exemplarLabel|online|language\nurn:cts:citedemo:gburg.hay.v2:|section|Gettysburg Address|Text of John Hay|second HC digital edition|nothing|true|eng\nurn:cts:citedemo:gburg.everett.v2:|section|Gettysburg Address|Text of Edward Everett|second HC digital edition|nothing|true|eng"
    @test cex(catalog) == expectedcex

    @test fromcex(expectedcex, TextCatalogCollection) == catalog
end

@testset "Test dispatch of fromcex" begin
    f = joinpath("data", "gettysburgcatalog.cex")
    filecatalog = fromcex(f, TextCatalogCollection, FileReader)

    url = "https://raw.githubusercontent.com/cite-architecture/CitableCorpus.jl/main/test/data/gettysburgcatalog.cex"
    urlcatalog = fromcex(url, TextCatalogCollection, UrlReader)

    @test filecatalog == urlcatalog
end


@testset "Test iteration for TextCatalogCollection" begin
    hay = entry(CtsUrn("urn:cts:citedemo:gburg.hay.v2:"), "section", "Gettysburg Address", "Text of John Hay", "second HC digital edition")
    everett = entry(CtsUrn("urn:cts:citedemo:gburg.everett.v2:"), "section", "Gettysburg Address", "Text of Edward Everett", "second HC digital edition")
    catalog = TextCatalogCollection([hay, everett])

    @test collect(catalog) == [hay, everett]
    @test length(catalog) == 2
    @test eltype(catalog) == CatalogedText


end


@testset "Test tables interface on TextCatalogCollection" begin
    f = joinpath("data", "gettysburgcatalog.cex")
    catalog = fromcex(f, TextCatalogCollection, FileReader)

    @test Tables.istable(catalog)
    @test Tables.rows(catalog) |>collect |> length == 5
    @test Tables.columns(catalog) |> collect |> length == 8

    rows = Tables.rows(catalog) |> collect
    urn1 = CtsUrn("urn:cts:citedemo:gburg.bancroft.v2:")
    @test Tables.getcolumn(rows[1], 1) == urn1
    @test Tables.getcolumn(rows[1], :urn) == urn1


end
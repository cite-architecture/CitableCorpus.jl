

@testset "Test constructing catalog entry from text array" begin
    cexsrc = "urn:cts:latinLit:stoa1263.stoa001.hc:|chapter,section|Hyginus|Fabulae|Holy Cross edition||true|lat"
    cataloged = catalogedtext(cexsrc)
    @test isa(cataloged, CatalogedText)
    @test cataloged.online
end

@testset "Test round-tripping CEX for CatalogedText" begin
    cexsrc = "urn:cts:latinLit:stoa1263.stoa001.hc:|chapter,section|Hyginus|Fabulae|Holy Cross edition||true|lat"
    cataloged = catalogedtext(cexsrc)
    @test cexsrc == cex(cataloged)
end

@testset "Test converting an array of CEX lines to a DataFrame" begin
    cexsrc = "#!ctscatalog\nurn|itation|group|title|version|exemplar|online|lang\nurn:cts:latinLit:stoa1263.stoa001.hc:|chapter,section|Hyginus|Fabulae|Holy Cross edition||true|lat"
    df = catalogdf_fromcex(cexsrc)
    @test isa(df, DataFrame)
end

@testset "Test loading a catalog from a local file into a DataFrame" begin
    catfile = "data/catalog.cex"
    catalog_df = catalogdf_fromfile(catfile)
    @test isa(catalog_df, DataFrame)
end

@testset "Determine citation depth for a cataloged text" begin
    cex = "urn:cts:latinLit:stoa1263.stoa001.hc:|chapter,section|Hyginus|Fabulae|Holy Cross edition||true|lat"
    cataloged = catalogedtext(cex)
    @test citationdepth(cataloged) == 2
end


@testset "Find in a dataframe of catalog data the citation depth for a cataloged text" begin
    data = "#!ctscatalog\nurn|citation|group|title|version|exempar}online|lang\nurn:cts:latinLit:stoa1263.stoa001.hc:|chapter,section|Hyginus|Fabulae|Holy Cross edition||true|lat"
    catalogdf = catalogdf_fromcex(data)


    urn = CtsUrn("urn:cts:latinLit:stoa1263.stoa001.hc:")
    depth = citationdepth(urn, catalogdf)

    @test depth == 2
end


@testset "Test constructing catalog entry from text array" begin
    cex = split("urn:cts:latinLit:stoa1263.stoa001.hc:|chapter,section|Hyginus|Fabulae|Holy Cross edition||true|lat", "|")
    cataloged = catalog(cex)
    @test isa(cataloged, CatalogedText)
    @test cataloged.online
end

@testset "Unmarshall CatalogedText" begin
    cex = split("urn:cts:latinLit:stoa1263.stoa001.hc:|chapter,section|Hyginus|Fabulae|Holy Cross edition||true|lat", "|")
    cataloged = catalog(cex)
    unmarshalled = CitableCorpus.unmarshall(cataloged)
    # Need equality test on CtsUrns from 
    
    @test_broken all(unmarshalled .==
    [CtsUrn("urn:cts:latinLit:stoa1263.stoa001.hc:"), 
    "chapter,section", 
    "Hyginus", "Fabulae", "Holy Cross edition", nothing, 
    true, "lat"])
    
end

@testset "Test converting an array of CatalogedTexts to a DataFrame" begin
    cex = split("urn:cts:latinLit:stoa1263.stoa001.hc:|chapter,section|Hyginus|Fabulae|Holy Cross edition||true|lat", "|")
    cataloged = [catalog(cex)]
    df = cataloged_to_df(cataloged)
    @test isa(df, DataFrame)

end


@testset "Test loading a catalog from a local file into a DataFrame" begin
    catfile = "data/catalog.csv"
    catalog_df = df_fromfile(catfile)
    @test isa(catalog_df, DataFrame)
end

@testset "Determine citation depth for a cataloged text" begin
    cex = split("urn:cts:latinLit:stoa1263.stoa001.hc:|chapter,section|Hyginus|Fabulae|Holy Cross edition||true|lat", "|")
    cataloged = catalog(cex)
    @test citationdepth(cataloged) == 2
end


@testset "Find in a dataframe of catalog data the citation depth for a cataloged text" begin
    #=
    cex = split("urn:cts:latinLit:stoa1263.stoa001.hc:|chapter,section|Hyginus|Fabulae|Holy Cross edition||true|lat", "|")
    cataloged = catalog(cex)
    df = cataloged_to_df([cataloged])
    urn = CtsUrn("urn:cts:latinLit:stoa1263.stoa001.hc:")
    depth = citationdepth(urn, df)
    
    =#
    depth = 1
    @test_broken depth == 2
end
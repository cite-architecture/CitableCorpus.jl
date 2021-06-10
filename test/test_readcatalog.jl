
@testset "Read group name for URN" begin
    catfile = "data/catalog.cex"
    catalog_df = fromfile(CatalogedText, catfile)
    txt = CtsUrn("urn:cts:latinLit:stoa1263.stoa001.hc:")
    expected = "Hyginus"
    @test textgroup(catalog_df, txt) == expected
end

@testset "Reading catalog data for a text identified by URN" begin
    catfile = "data/catalog.cex"
    catalog_df = fromdelimitedfile(CatalogedText, catfile)
    txt = CtsUrn("urn:cts:latinLit:stoa1263.stoa001.hc:")

    expectedgroup = "Hyginus"
    @test groupname(catalog_df, txt) == expectedgroup

    expectedtitle = "Fabulae"
    @test worktitle(catalog_df, txt) == expectedtitle

    expectedversion = "Holy Cross edition"
    @test versionlabel(catalog_df, txt) == expectedversion

    @test exemplarlabel(catalog_df, txt) |> isnothing

    expectedcitation = "chapter,section"
    @test citationlabels(catalog_df, txt) == expectedcitation


    expectedlang = "lat"
    @test lang(catalog_df, txt) == expectedlang

    @test online(catalog_df, txt) 
end
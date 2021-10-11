@testset "Test assignment of CitableTrait" begin
    psg = CitableCorpus.passage_fromcex("urn:cts:greekLit:tlg0012.tlg001.nx:1.1|Wrathful text")
    @test CitableTrait(typeof(psg)) == CitableByCtsUrn()


    iliad = CtsUrn("urn:cts:greekLit:tlg0012.tlg001.nx:")
    doc = CitableDocument(iliad,"Non-Iliad", [psg])
    @test CitableTrait(typeof(doc)) == CitableByCtsUrn()


    data = "urn:cts:latinLit:stoa1263.stoa001.hc:|chapter,section|Hyginus|Fabulae|Holy Cross edition||true|lat"
    cataloged = catalogedtext(data)
    @test CitableTrait(typeof(cataloged)) == CitableByCtsUrn()
end


@testset "Test internal structure of CitablePassage" begin
        u = CtsUrn("urn:cts:greekLit:tlg0012.tlg001:1.1")
        content = "μῆνιν ἄειδε, θεά, Πηληϊάδεω Ἀχιλῆος"
        psg = CitablePassage(u,content)
        @test psg.text == content
        @test psg.urn == u
end

@testset "Test Citable interface on CitablePassage" begin
        u = CtsUrn("urn:cts:greekLit:tlg0012.tlg001:1.1")
        content = "μῆνιν ἄειδε, θεά, Πηληϊάδεω Ἀχιλῆος"
        psg = CitablePassage(u,content)  

        @test citabletrait(typeof(psg)) == PassageCitableByCtsUrn()
        @test citable(psg) 
        @test label(psg) == "μῆνιν ἄειδε, θεά, Πηληϊάδεω Ἀχιλῆος"
        @test urn(psg) == u        
end


@testset "Test urn comparison on CitablePassage" begin
        u = CtsUrn("urn:cts:greekLit:tlg0012.tlg001:1.1")
        content = "μῆνιν ἄειδε, θεά, Πηληϊάδεω Ἀχιλῆος"
        psg = CitablePassage(u,content)

        @test_broken urncomparisontrait(typeof(psg)) == CtsUrnComparablePassage()
        @test_broken urncomparable(psg)
        


        bkurn = CtsUrn("urn:cts:greekLit:tlg0012.tlg001:1")
        @test_broken urnequals(psg, u)
        @test_broken urncontains(psg, bkurn)
        @test_broken urnsimilar(psg, bkurn)
end

@testset "Test CEX parsing for CitablePassage" begin
        psg = CitablePassage(CtsUrn("urn:cts:greekLit:tlg0012.tlg001:1.1"), "μῆνιν ἄειδε, θεά, Πηληϊάδεω Ἀχιλῆος")
        
        @test_broken cextrait(typeof(psg)) == CexPassage()
        @test cexserializable(psg)
        # Round trip it!
        @test psg == fromcex(cex(psg), CitablePassage)
        
        # Check error handling:
        @test_throws DomainError fromcex("No columns", CitablePassage)
        @test_throws DomainError fromcex("Too|many|darn|columns!|", CitablePassage)
end
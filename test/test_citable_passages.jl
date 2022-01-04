
@testset "Test internal structure of CitablePassage" begin
        u = CtsUrn("urn:cts:greekLit:tlg0012.tlg001:1.1")
        content = "μῆνιν ἄειδε, θεά, Πηληϊάδεω Ἀχιλῆος"
        psg = CitablePassage(u,content)
        @test psg.text == content
        @test psg.urn == u
        @test text(psg) == content
end

@testset "Test Citable interface on CitablePassage" begin
        u = CtsUrn("urn:cts:greekLit:tlg0012.tlg001:1.1")
        content = "μῆνιν ἄειδε, θεά, Πηληϊάδεω Ἀχιλῆος"
        psg = CitablePassage(u,content)  

        @test citabletrait(typeof(psg)) == PassageCitableByCtsUrn()
        @test citable(psg) 
        
        @test urn(psg) == u    
        @test label(psg) == "<urn:cts:greekLit:tlg0012.tlg001:1.1> μῆνιν ἄειδε, θεά, Πηληϊάδεω Ἀχιλῆος"
end

@testset "Test urn comparison on CitablePassage" begin
        u = CtsUrn("urn:cts:greekLit:tlg0012.tlg001:1.1")
        content = "μῆνιν ἄειδε, θεά, Πηληϊάδεω Ἀχιλῆος"
        psg = CitablePassage(u,content)

        @test urncomparisontrait(typeof(psg)) == CtsUrnComparablePassage()
        @test urncomparable(psg)
      
        bkurn = CtsUrn("urn:cts:greekLit:tlg0012.tlg001:1")
        @test urnequals(psg, u)
        @test urncontains(psg, bkurn)
        @test urnsimilar(psg, bkurn)
end

@testset "Test CEX parsing for CitablePassage" begin
        psg = CitablePassage(CtsUrn("urn:cts:greekLit:tlg0012.tlg001:1.1"), "μῆνιν ἄειδε, θεά, Πηληϊάδεω Ἀχιλῆος")
        
        @test cextrait(typeof(psg)) == CexPassage()
        @test cexserializable(psg)
        # Round trip it!
        @test psg == fromcex(cex(psg), CitablePassage)
        
        # Test error handling:
        @test_throws DomainError fromcex("No columns", CitablePassage)
        @test_throws DomainError fromcex("Too|many|darn|columns!|", CitablePassage)
end
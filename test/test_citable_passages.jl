
@testset "Construct citable passage" begin
        u = CtsUrn("urn:cts:greekLit:tlg0012.tlg001:1.1")
        content = "μῆνιν ἄειδε, θεά, Πηληϊάδεω Ἀχιλῆος"
        psg = CitablePassage(u,content)
        @test psg.text == content
        @test psg.urn == u
end

@testset "Test functions required for Citable interface" begin
        u = CtsUrn("urn:cts:greekLit:tlg0012.tlg001:1.1")
        content = "μῆνιν ἄειδε, θεά, Πηληϊάδεω Ἀχιλῆος"
        psg = CitablePassage(u,content)   
        @test label(psg) == "μῆνιν ἄειδε, θεά, Πηληϊάδεω Ἀχιλῆος"
        @test urn(psg) == u
        @test cex(psg) == "urn:cts:greekLit:tlg0012.tlg001:1.1|μῆνιν ἄειδε, θεά, Πηληϊάδεω Ἀχιλῆος"
end


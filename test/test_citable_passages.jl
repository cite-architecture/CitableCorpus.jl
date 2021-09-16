
@testset "Construct citable node" begin
        u = CtsUrn("urn:cts:greekLit:tlg0012.tlg001:1.1")
        content = "μῆνιν ἄειδε, θεά, Πηληϊάδεω Ἀχιλῆος"
        psg = CitablePassage(u,content)
        @test psg.text == content
        @test psg.urn == u
end


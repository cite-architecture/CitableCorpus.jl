
@testset "Construct citable node" begin
        urn = CtsUrn("urn:cts:greekLit:tlg0012.tlg001:1.1")
        content = "μῆνιν ἄειδε, θεά, Πηληϊάδεω Ἀχιλῆος"
        cn = CitablePassage(urn,content)
        @test cn.text == content
end


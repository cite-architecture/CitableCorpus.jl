@testset "Manually construct a citable corpus" begin
        urn = CtsUrn("urn:cts:greekLit:tlg0012.tlg001:1.1")
        content = "μῆνιν ἄειδε, θεά, Πηληϊάδεω Ἀχιλῆος"
        cn = CitableNode(urn,content)
        c = CitableTextCorpus([cn])
        @test c.corpus[1] == cn
end

@testset "Build a corpus from a delimited-text string" begin
        cex = """urn:cts:latinLit:stoa1263.stoa001.hc:t.1#EXCERPTA EX HYGINI GENEALOGIIS, VOLGO FABVLAE.
urn:cts:latinLit:stoa1263.stoa001.hc:pr.1#Ex Caligine Chaos: ex Chao et Caligine Nox Dies Erebus Aether. ex Nocte et Erebo Fatum Senectus Mors Letum Continentia Somnus Somnia Amor id est Lysimeles, Epiphron dumiles Porphyrion Epaphus Discordia Miseria Petulantia Nemesis Euphrosyne Amicitia Misericordia Styx; Parcae tres, id est Clotho Lachesis Atropos; Hesperides, Aegle Hesperie aerica.
urn:cts:latinLit:stoa1263.stoa001.hc:pr.2#Ex Aethere et Die Terra Caelum Mare.
urn:cts:latinLit:stoa1263.stoa001.hc:pr.3#Ex Aethere et Terra Dolor Dolus Ira Luctus Mendacium Iusiurandum Vltio Intemperantia Altercatio Obliuio Socordia Timor Superbia Incestum Pugna Oceanus Themis Tartarus Pontus; et Titanes, Briareus Gyges Steropes Atlas Hyperion et Polus, Saturnus Ops Moneta Dione; Furiae tres, id est Alecto Megaera Tisiphone.
urn:cts:latinLit:stoa1263.stoa001.hc:pr.4#Ex Terra et Tartaro Gigantes, Enceladus Coeus elentes mophius Astraeus Pelorus Pallas Emphytus Rhoecus ienios Agrius alemone Ephialtes Eurytus effracorydon Theomises Theodamas Otus Typhon Polyboetes menephriarus abesus colophonus Iapetus.
urn:cts:latinLit:stoa1263.stoa001.hc:pr.5#Ex Ponto et Mari piscium genera.
"""     
        c = fromdelimited(CitableTextCorpus, cex, "#")
        @test isa(c, CitableTextCorpus)
end

@testset "Load a corpus from a file" begin
        f = "data/hyginus.csv"
        c = fromfile(CitableTextCorpus, f, "#")
        @test isa(c, CitableTextCorpus)
end


@testset "Combine two copora" begin
        f = "data/hyginus.csv"
        c1 = fromfile(CitableTextCorpus, f, "#")  
        c2 = fromfile(CitableTextCorpus, f, "#")  
        @test length(c1.corpus) == 1234
        combo = CitableText.combine(c1, c2)
        @test length(combo.corpus) == 2468
        @test isa(combo, CitableTextCorpus)
end


@testset "Recursively composite an array of corpora" begin
        f = "data/hyginus.csv"
        c = fromfile(CitableTextCorpus, f, "#")  
        @test length(c.corpus) == 1234
        combo = CitableText.composite_array([c, c, c, c])
        @test length(combo.corpus) == 4936
        @test isa(combo, CitableTextCorpus)
end


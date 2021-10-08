@testset "Manually construct a citable corpus" begin
        urn = CtsUrn("urn:cts:greekLit:tlg0012.tlg001:1.1")
        content = "μῆνιν ἄειδε, θεά, Πηληϊάδεω Ἀχιλῆος"
        cn = CitablePassage(urn,content)
        c = CitableTextCorpus([cn])
        @test c.passages[1] == cn
end

@testset "Build a corpus from a delimited-text string" begin
        cexsrc = """!#ctsdata
urn:cts:latinLit:stoa1263.stoa001.hc:t.1#EXCERPTA EX HYGINI GENEALOGIIS, VOLGO FABVLAE.
urn:cts:latinLit:stoa1263.stoa001.hc:pr.1#Ex Caligine Chaos: ex Chao et Caligine Nox Dies Erebus Aether. ex Nocte et Erebo Fatum Senectus Mors Letum Continentia Somnus Somnia Amor id est Lysimeles, Epiphron dumiles Porphyrion Epaphus Discordia Miseria Petulantia Nemesis Euphrosyne Amicitia Misericordia Styx; Parcae tres, id est Clotho Lachesis Atropos; Hesperides, Aegle Hesperie aerica.
urn:cts:latinLit:stoa1263.stoa001.hc:pr.2#Ex Aethere et Die Terra Caelum Mare.
urn:cts:latinLit:stoa1263.stoa001.hc:pr.3#Ex Aethere et Terra Dolor Dolus Ira Luctus Mendacium Iusiurandum Vltio Intemperantia Altercatio Obliuio Socordia Timor Superbia Incestum Pugna Oceanus Themis Tartarus Pontus; et Titanes, Briareus Gyges Steropes Atlas Hyperion et Polus, Saturnus Ops Moneta Dione; Furiae tres, id est Alecto Megaera Tisiphone.
urn:cts:latinLit:stoa1263.stoa001.hc:pr.4#Ex Terra et Tartaro Gigantes, Enceladus Coeus elentes mophius Astraeus Pelorus Pallas Emphytus Rhoecus ienios Agrius alemone Ephialtes Eurytus effracorydon Theomises Theodamas Otus Typhon Polyboetes menephriarus abesus colophonus Iapetus.
urn:cts:latinLit:stoa1263.stoa001.hc:pr.5#Ex Ponto et Mari piscium genera.
"""     
        c = corpus_fromcex(cexsrc, "#")
        @test isa(c, CitableTextCorpus)
end

@testset "Load a corpus from a file" begin
        f = "data/hyginus.cex"
        c = read(f, String) |> corpus_fromcex
        @test isa(c, CitableTextCorpus)
end


@testset "Combine two copora" begin
        f = "data/hyginus.cex"
        c1 = read(f, String) |> corpus_fromcex
        c2 =  read(f, String) |> corpus_fromcex
        @test length(c1.passages) == 1234
        combo = CitableCorpus.combine(c1, c2)
        @test length(combo.passages) == 2468
        @test isa(combo, CitableTextCorpus)
end


@testset "Recursively composite an array of corpora" begin
        f = "data/hyginus.cex"
        c = read(f, String) |> corpus_fromcex
        @test length(c.passages) == 1234
        combo = CitableCorpus.combine([c, c, c, c])
        @test length(combo.passages) == 4936
        @test isa(combo, CitableTextCorpus)
end



@testset "Find URNs for documents in a corpus" begin
        f = joinpath(dirname(pwd()), "docs", "data", "gettysburgcorpus.cex")
        c = read(f, String) |> corpus_fromcex
        docurns = document_urns(c)
        @test length(docurns) == 5
end

@testset "Extract a citable document from a corpus" begin
        f = joinpath(dirname(pwd()), "docs", "data", "gettysburgcorpus.cex")
        c = read(f, String) |> corpus_fromcex
        hay =  CtsUrn("urn:cts:citedemo:gburg.hay.v2:")
        doc = document(hay, c)
        @test isa(doc, CitableDocument)
        @test length(doc.passages) == 4
end

@testset "Convert corpus to a list of citable documents" begin
        f = joinpath(dirname(pwd()), "docs", "data", "gettysburgcorpus.cex")
        corp = read(f, String) |> corpus_fromcex
        alldocs = documents(corp)
        @test length(alldocs) == 5
        for doc in alldocs
                @test isa(doc, CitableDocument)
        end
end


@testset "Overload *fromcex methods to read from Vector of bytes" begin
        f = "data/hyginus.cex"
        corpus = read(f) |> corpus_fromcex
        @test length(corpus.passages) == 1234
end
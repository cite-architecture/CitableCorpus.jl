
@testset "Test corpus navigation" begin
    
    cexsrc = """#!ctsdata
urn:cts:latinLit:stoa1263.stoa001.hc:t.1#EXCERPTA EX HYGINI GENEALOGIIS, VOLGO FABVLAE.
urn:cts:latinLit:stoa1263.stoa001.hc:pr.1#Ex Caligine Chaos: ex Chao et Caligine Nox Dies Erebus Aether. ex Nocte et Erebo Fatum Senectus Mors Letum Continentia Somnus Somnia Amor id est Lysimeles, Epiphron dumiles Porphyrion Epaphus Discordia Miseria Petulantia Nemesis Euphrosyne Amicitia Misericordia Styx; Parcae tres, id est Clotho Lachesis Atropos; Hesperides, Aegle Hesperie aerica.
urn:cts:latinLit:stoa1263.stoa001.hc:pr.2#Ex Aethere et Die Terra Caelum Mare.
urn:cts:latinLit:stoa1263.stoa001.hc:pr.3#Ex Aethere et Terra Dolor Dolus Ira Luctus Mendacium Iusiurandum Vltio Intemperantia Altercatio Obliuio Socordia Timor Superbia Incestum Pugna Oceanus Themis Tartarus Pontus; et Titanes, Briareus Gyges Steropes Atlas Hyperion et Polus, Saturnus Ops Moneta Dione; Furiae tres, id est Alecto Megaera Tisiphone.
urn:cts:latinLit:stoa1263.stoa001.hc:pr.4#Ex Terra et Tartaro Gigantes, Enceladus Coeus elentes mophius Astraeus Pelorus Pallas Emphytus Rhoecus ienios Agrius alemone Ephialtes Eurytus effracorydon Theomises Theodamas Otus Typhon Polyboetes menephriarus abesus colophonus Iapetus.
urn:cts:latinLit:stoa1263.stoa001.hc:pr.5#Ex Ponto et Mari piscium genera.
"""     
    c = fromcex(cexsrc, CitableTextCorpus; delimiter = "#")
    @test length(c.passages) == 6
  
    @test next(c.passages[1].urn, c) == c.passages[2]
    @test isnothing(prev(c.passages[1].urn, c))

    @test next(c.passages[6].urn, c) |> isnothing
    @test next(c.passages[5].urn, c) == c.passages[6]

end

@testset "Test navigation in a corpus within in document" begin
    f = joinpath(dirname(pwd()), "docs", "data", "gettysburgcorpus.cex")
    corp = fromcex(read(f, String), CitableTextCorpus)
    lastbancroft = CtsUrn("urn:cts:citedemo:gburg.bancroft.v2:4")
    @test isnothing(next(lastbancroft, corp))
end
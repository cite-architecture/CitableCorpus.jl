
@testset "Test creating delimited text from corpus" begin
    src = """#!ctsdata\nurn:cts:latinLit:stoa1263.stoa001.hc:t.1#EXCERPTA EX HYGINI GENEALOGIIS, VOLGO FABVLAE.
"""     
    c = fromcex(src, CitableTextCorpus; delimiter = "#")
    @test isa(c, CitableTextCorpus)
    @test cex(c; delimiter = "#") == src 
end


@testset "Test checking new lines" begin
    txt = """EXCERPTA EX HYGINI GENEALOGIIS, 
VOLGO FABVLAE.
"""     
    urn = CtsUrn("urn:cts:latinLit:stoa1263.stoa001.hc:t.1")
    nd = CitablePassage(urn, txt)
    c = CitableTextCorpus([nd])
    @test isa(c, CitableTextCorpus)
    lns =  split(cex(c), "\n")
    @test length(lns) == 3
    @test isempty(lns[3])
end
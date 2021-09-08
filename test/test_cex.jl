
@testset "Test creating delimited text from corpus" begin
    src = """urn:cts:latinLit:stoa1263.stoa001.hc:t.1#EXCERPTA EX HYGINI GENEALOGIIS, VOLGO FABVLAE.
"""     
    c = corpus_fromdelimited(src, "#")
    @test isa(c, CitableTextCorpus)
    @test cex(c, "#")== src 
end


@testset "Test checking new lines" begin
    txt = """EXCERPTA EX HYGINI GENEALOGIIS, 
VOLGO FABVLAE.
"""     
    urn = CtsUrn("urn:cts:latinLit:stoa1263.stoa001.hc:t.1")
    nd = CitableNode(urn, txt)
    c = CitableTextCorpus([nd])
    @test isa(c, CitableTextCorpus)
    lns =  split(cex(c), "\n")
    @test length(lns) == 2
    @test isempty(lns[2])
end
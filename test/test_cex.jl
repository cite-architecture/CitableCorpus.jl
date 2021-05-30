
@testset "Test creating delimited text from corpus" begin
    src = """urn:cts:latinLit:stoa1263.stoa001.hc:t.1#EXCERPTA EX HYGINI GENEALOGIIS, VOLGO FABVLAE.
"""     
    c = fromdelimited(CitableCorpus, src, "#")
    @test isa(c, CitableCorpus)
    @test cex(c, "#")== src 
end
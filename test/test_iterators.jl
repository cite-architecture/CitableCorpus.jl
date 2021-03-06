@testset "Test iterator functions" begin
    f = "data/hyginus.cex"
    c = fromcex(read(f, String), CitableTextCorpus)

    count = 0
    for psg in c
        count = count + 1
    end
    @test count == length(c.passages)

    doc = documents(c)[1]
    count = 0
    for psg in doc
        count = count + 1
    end
    @test count == length(doc.passages)
end
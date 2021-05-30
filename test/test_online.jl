
@testset "Load a corpus from a url" begin
    url = "https://raw.githubusercontent.com/LinguaLatina/texts/master/texts/latin23/hyginus.cex"
    c = fromurl(CiteCorpus, url, "#")
    @test isa(c, CiteCorpus)
end

@test "Load an array of CatalogedTexts from a file" begin
    # TBA
end
@testset "Test CitableLibraryTrait functions" begin
    f = joinpath(dirname(pwd()), "docs", "data", "gettysburgcorpus.cex")
    corpus = fromcex(read(f, String), CitableTextCorpus)
    bancroft = CtsUrn("urn:cts:citedemo:gburg.bancroft.v2:")
end
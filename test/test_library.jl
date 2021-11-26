@testset "Test CitableLibraryTrait functions" begin
    f = joinpath(dirname(pwd()), "docs", "data", "gettysburgcorpus.cex")
    corpus = read(f, String) |> corpus_fromcex
    bancroft = CtsUrn("urn:cts:citedemo:gburg.bancroft.v2:")
end
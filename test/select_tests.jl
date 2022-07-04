using Pkg
Pkg.activate("..")

using CitableCorpus
using CitableBase
using CitableText
using CiteEXchange
using HTTP
using Tables

using Compat.Test
using TestSetExtensions

@testset "All the tests" begin
    println(map(s -> replace(s, r".jl$" => ""), ARGS))
    @includetests map(s -> replace(s, r".jl$" => ""), ARGS)
end

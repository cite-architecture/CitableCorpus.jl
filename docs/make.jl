# Use this from root directory of repository, e.g.,
# julia --project=docs/ docs/make.jl

using Pkg
Pkg.activate(".")
Pkg.instantiate()


using Documenter, DocStringExtensions, CitableTextCorpus

makedocs(
    sitename = "CitableTextCorpus.jl",
    pages = [
        "Home" => "index.md"    ]
    )


    deploydocs(
    repo = "github.com/cite-architecture/CitableCorpus.jl.git",
) 
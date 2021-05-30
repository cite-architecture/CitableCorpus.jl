# Use this from root directory of repository, e.g.,
# julia --project=docs/ docs/make.jl

using Pkg
Pkg.activate(".")
Pkg.instantiate()


using Documenter, DocStringExtensions, CiteCorpus

makedocs(
    sitename = "CiteCorpus.jl",
    pages = [
        "Home" => "index.md"    ]
    )

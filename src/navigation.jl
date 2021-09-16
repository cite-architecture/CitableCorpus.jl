# Functions for navigation and retreival in a CitableTextCorpus

"""
$(SIGNATURES)
Retrieve citable node following a given citable node in a corpus.
If `n` is the last node in the corpus, return `nothing`.
"""
function nextnode(n::CitablePassage, c::CitableTextCorpus)
    idx = findfirst(cn -> cn == n, c.corpus)
    if idx == size(c.corpus, 1)
        nothing
    else
        c.corpus[idx + 1]
    end
end


"""
$(SIGNATURES)
Retrieve citable node preceding a given citable node in a corpus.
If `n` is the first node in the corpus, return `nothing`.
"""
function prevnode(n::CitablePassage, c::CitableTextCorpus)
    idx = findfirst(cn -> cn == n, c.corpus)
    if idx == 1
        nothing
    else
        c.corpus[idx - 1]
    end
end
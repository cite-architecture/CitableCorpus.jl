# Functions for navigation and retreival in a CitableTextCorpus

"""
$(SIGNATURES)
Retrieve citable node following a given citable node in a corpus.
If `n` is the last node in the corpus, return `nothing`.
"""
function nextpassage(n::CitablePassage, c::CitableTextCorpus)
    idx = findfirst(cn -> cn == n, c.passage)
    if idx == size(c.passage, 1)
        nothing
    else
        c.passage[idx + 1]
    end
end


"""
$(SIGNATURES)
Retrieve citable node preceding a given citable node in a corpus.
If `n` is the first node in the corpus, return `nothing`.
"""
function prevpassage(n::CitablePassage, c::CitableTextCorpus)
    idx = findfirst(cn -> cn == n, c.passage)
    if idx == 1
        nothing
    else
        c.passage[idx - 1]
    end
end
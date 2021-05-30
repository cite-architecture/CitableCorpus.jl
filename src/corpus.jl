"A canonically citable text corpus."
struct CitableCorpus
    corpus
end

"""
$(SIGNATURES)
Create a DataFrame from a `CitableCorpus`
"""
function to_df(c::CitableCorpus)
    urns = map(cn -> cn.urn, c.corpus)
    psgs = map(cn -> cn.text, c.corpus)
    df = DataFrame(urn = urns,text = psgs)
    df
end

"""
$(SIGNATURES)
Create a single composite `CitableCorpus` from two
sources.
"""
function combine(c1::CitableCorpus, c2::CitableCorpus)
    CitableCorpus(vcat(c1.corpus, c2.corpus))
end


"""
$(SIGNATURES)
Create a single composite `CitableCorpus` from an
array of source corpora by recursively adding corpora.
"""
function composite_array(src_array, composite = nothing)
    if src_array === nothing || length(src_array) == 0
        composite
    else 
        trim = src_array[1]
        popfirst!(src_array) 
        if composite === nothing
            composite_array(src_array, trim)
        else
            newcomposite = combine(trim, composite)
            composite_array(src_array, newcomposite)
        end
    end
end
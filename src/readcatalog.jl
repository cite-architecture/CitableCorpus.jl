
"""Read text group value for a given text.
Returns nothing if no entry found
$(SIGNATURES)
"""
function textgroup(catalogdf, urn::CtsUrn)
    rows = filter(r -> urncontains(droppassage(urn), r[:urn]), catalogdf)
    if nrow(rows) == 0
        @warn("No entries for $urn found in catalog.")
        nothing
    elseif nrow(rows) > 1
        @warn("Multiple entries for $urn found in catalog.")
        nothing
    else
        rows[1, :group]
    end
end
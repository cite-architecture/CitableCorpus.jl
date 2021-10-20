"""Read text group name for a given text.
Returns nothing if no entry found
$(SIGNATURES)
"""
function groupname(catalogdf, urn::CtsUrn)
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

"""Read work title for a given text.
Returns nothing if no entry found
$(SIGNATURES)
"""
function worktitle(catalogdf, urn::CtsUrn)
    rows = filter(r -> urncontains(droppassage(urn), r[:urn]), catalogdf)
    if nrow(rows) == 0
        @warn("No entries for $urn found in catalog.")
        nothing
    elseif nrow(rows) > 1
        @warn("Multiple entries for $urn found in catalog.")
        nothing
    else
        s = rows[1, :work]
        isempty(s) ? nothing : s
    end
end

"""Read version label for a given text.
Returns nothing if no entry found
$(SIGNATURES)
"""
function versionlabel(catalogdf, urn::CtsUrn)
    rows = filter(r -> urncontains(droppassage(urn), r[:urn]), catalogdf)
    if nrow(rows) == 0
        @warn("No entries for $urn found in catalog.")
        nothing
    elseif nrow(rows) > 1
        @warn("Multiple entries for $urn found in catalog.")
        nothing
    else
        s = rows[1, :version]
        isempty(s) ? nothing : s
    end
end

"""Read exemplar label for a given text.
Returns nothing if no entry found
$(SIGNATURES)
"""
function exemplarlabel(catalogdf, urn::CtsUrn)
    rows = filter(r -> urncontains(droppassage(urn), r[:urn]), catalogdf)
    if nrow(rows) == 0
        @warn("No entries for $urn found in catalog.")
        nothing
    elseif nrow(rows) > 1
        @warn("Multiple entries for $urn found in catalog.")
        nothing
    else
        s = rows[1, :exemplar]
        isempty(s) ? nothing : s
    end
end

"""Read citable labels for a given text.
Returns nothing if no entry found, otherwise returns a
comma-delimited list of labels for each level of the citation
hierarchy.

$(SIGNATURES)
"""
function citationlabels(catalogdf, urn::CtsUrn)
    rows = filter(r -> urncontains(droppassage(urn), r[:urn]), catalogdf)
    if nrow(rows) == 0
        @warn("No entries for $urn found in catalog.")
        nothing
    elseif nrow(rows) > 1
        @warn("Multiple entries for $urn found in catalog.")
        nothing
    else
        rows[1, :citation]
    end
end

"""Read ISO language code for `urn` from catalog.
Returns nothing if no entry found.

$(SIGNATURES)
"""
function lang(catalogdf, urn::CtsUrn)
    rows = filter(r -> urncontains(droppassage(urn), r[:urn]), catalogdf)
    if nrow(rows) == 0
        @warn("No entries for $urn found in catalog.")
        nothing
    elseif nrow(rows) > 1
        @warn("Multiple entries for $urn found in catalog.")
        nothing
    else
        rows[1, :lang]
    end
end

"""True if text identified by `urn` is online.

$(SIGNATURES)
"""
function online(catalogdf, urn::CtsUrn)
    rows = filter(r -> urncontains(droppassage(urn), r[:urn]), catalogdf)
    if nrow(rows) == 0
        @warn("No entries for $urn found in catalog.")
        false
    elseif nrow(rows) > 1
        @warn("Multiple entries for $urn found in catalog.")
        false
    else
        rows[1, :online]
    end
end
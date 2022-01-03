
@testset "Test structure of citable document" begin
    hay_urn = CtsUrn("urn:cts:citedemo:gburg.hay.v2:")
    hay_title = "Gettsyburg Address (Hay's version)"
    hay_passages = [
        CitablePassage(CtsUrn("urn:cts:citedemo:gburg.hay.v2:1"), "Four score and seven years ago our fathers brought forth, upon this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal."),
        CitablePassage(CtsUrn("urn:cts:citedemo:gburg.hay.v2:2"), "Now we are engaged in a great civil war, testing whether that nation, or any nation so conceived, and so dedicated, can long endure. We are met here on a great battlefield of that war. We have come to dedicate a portion of it, as a final resting place for those who here gave their lives that that nation might live. It is altogether fitting and proper that we should do this."),
        CitablePassage(CtsUrn("urn:cts:citedemo:gburg.hay.v2:3"), "But in a larger sense, we can not dedicate we can not consecrate we can not hallow this ground. The brave men, living and dead, who struggled here, have consecrated it far above our poor power to add or detract. The world will little note, nor long remember, what we say here, but can never forget what they did here."),
        CitablePassage(CtsUrn("urn:cts:citedemo:gburg.hay.v2:4"), "It is for us, the living, rather to be dedicated here to the unfinished work which they have, thus far, so nobly carried on. It is rather for us to be here dedicated to the great task remaining before us that from these honored dead we take increased devotion to that cause for which they gave the last full measure of devotion that we here highly resolve that these dead shall not have died in vain; that this nation shall have a new birth of freedom; and that this government of the people, by the people, for the people, shall not perish from the earth.")
    ]
    hay_doc = CitableDocument(hay_urn, hay_title, hay_passages)


    @test length(hay_doc.passages) == 4
    @test hay_doc.title == "Gettsyburg Address (Hay's version)" 
    @test hay_doc.urn == hay_urn

    dupe = hay_doc
    @test hay_doc == dupe
end


@testset "Test Citable interface on CitableDocument" begin

end


@testset "Test URN cex serialization on CitableDocument" begin

end

@testset "Test URN comparison on CitableDocument" begin

end

@testset "Test collection trait on CitableDocument" begin
end

@testset "Test iteration on CitableDocument" begin
    
end
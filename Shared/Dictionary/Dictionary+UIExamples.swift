let examplePhrase = Dictionary.Phrase(
    id: "a4a7d64448a624da27c3026686ec9140",
    source: Dictionary.Phrase.Translation(soundUrl: nil, translation: "В неділю я хочу відпочити.", transcription: "V nedilju ja choču vidpočyty"),
    main: Dictionary.Phrase.Translation(soundUrl: nil, translation: "V neděli chci odpočívat.", transcription: "В недєли хци отпочіват"),
    imageUrl: nil
)

let exampleCategory = Dictionary.Category(
    id: "bd4e4bfdf11933d9b65e18eace65a3ad",
    name: Dictionary.Category.Name(source: "Час", main: "Čas"),
    phrases: ["a4a7d64448a624da27c3026686ec9140"]
)

let exampleDictionary = Dictionary(
    main: "cs",
    source: "uk",
    categories: [exampleCategory],
    phrases: ["a4a7d64448a624da27c3026686ec9140": examplePhrase]
)

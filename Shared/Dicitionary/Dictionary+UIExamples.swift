
let exampleTranslation = Dictionary.Translation(
    id: "a4a7d64448a624da27c3026686ec9140",
    translationFrom: "V neděli chci odpočívat.",
    transcriptionFrom: "В недєли хци отпочіват",
    translationTo: "В неділю я хочу відпочити.",
    transcriptionTo: "V nedilju ja choču vidpočyty"
)

let exampleSection = Dictionary.Section(
    id: "bd4e4bfdf11933d9b65e18eace65a3ad",
    nameFrom: "Čas",
    nameTo: "Час",
    translations: ["a4a7d64448a624da27c3026686ec9140"]
)

let exampleDictionary = Dictionary(
    from: "cs",
    to: "uk",
    sections: [exampleSection],
    translations: ["a4a7d64448a624da27c3026686ec9140": exampleTranslation]
)

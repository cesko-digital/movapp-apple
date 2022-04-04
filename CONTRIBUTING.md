# Přidej se k vývoji MOVAPP na Apple zařízení

- [Správa slovíček](translations/README.md) 

## Assets

- Barvy jsou v `colors/{name}` namespace.
- Ikony vkládejte do `icons/{name}` namespace.
    - pod složky vytvářejte, nezapomenou zaškrnout `Provide namespace`.
    - Použijte SVG. 
    - Nastavte canvas 24x24, aby se ikony dobře vykreslovali (https://stackoverflow.com/a/67430823/740949)
    - Pri vložení nastavit `Render As: Template` a `Scales: Single Scale`.
    - Barvu pak změníte v SwiftUI.
    
    ```swift
    Image("icons/play")
        .foregroundColor(Color("colors/accent"))
    ```

## Obrazovky

- Každá oblast má vlastní složku (Slovníček = Dictionary).
- Všechny "views" seskupuje `RootContentView` v `Root` složce (zde je Tabview).

### Přidání nového tabu

- Přidej `case` do `RootItems`.
- Přidej ikonku do assets.
- Vytvoř novou složku pro view (název tvé tabu)
- Vykresli obrazovku v `RootContentView`


## Jazyky

Každý jazykový překlad (například: čeština -> ukrajinština) je v aplikaci:

- definována pomocí `Language` structu. Zde se definuje
    - Výchozí jazyk
    - Cílový jazyk
    - Prefix souborů pro načtení `json`. Dále jako `filePrefix`.
- Následně interpretována jako `SetLanguage` (umožnuje prohození jazyku).
    - Toto nastavíš v `SetLanguage`, podívej se na konec souboru kde najdeš `extension SetLanguage` a deklaraci `SetLanguage` proměnných.
    - Deklaruješ si lokálně proměnou svého jazyku a vytvoříš 2 statické proměnné (pro použití v preview apod), která bude obsahovat `SetLanguage`. 
    - V podstatě se podívej jak vypadá `csUk` a `ukCs` a udělej to stejně.
    - Aplikace automaticky přenačte jiný jazykový soubor pokud dojde ke změně výchozího jazyka za jiný. Jinak přehazuje "from" -> "to".
    - Přidej obě proměné do .allCases
- V Assets musí existovat soubor `translations-{filePrefix}` a `sections-{filePrefix}`



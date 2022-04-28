# Přidej se k vývoji Movapp na Apple zařízení

- [Správa slovíček](translations/README.md)

## Git

- Používejte rebase politiku (vždy vycházejte z `main`)
- Před mergem vždy rebasnete nad `main` a vyřešíte konflitky
- Pro vložení do `main` se provede squash commit a nebo si lokálně upravte komity

## Fastlane

Pro automatizaci releasů a souvisejících procesů používáme [Fastlane](https://fastlane.tools). Samotnou Fastlane můžete nainstalovat buď přes `brew install fastlane`, nebo lépe přímo v repository příkazem `bundle`. Ta lokální instalace v repu je lepší v tom, že všichni používáme stejnou verzi. Dál počítáme s tím, že jste Fastlane nainstalovali takhle. Pokud ne, pište místo `bundle exec fastlane` prostě jen `fastlane`.

## Podepisování

Pro podepsání kódu jsou potřeba certifikáty a profily, které se dají stáhnout přes Fastlane:

```
bundle exec fastlane match development --readonly
```

## Releasing

Během vývoje přidávejte informace o novinkách do souboru `CHANGELOG.md` do sekce `[Unreleased]`. Pokud v ní před releasem ještě něco chybí, doplňte a commitněte.

Pak vyrobíte nový release přes Fastlane:

```
bundle exec fastlane release
```

Tohle zvýší číslo buildu, aktualizuje changelog, commitne všechno do repa a otaguje release.

Pokud chcete zvýšit marketingové číslo verze, dělá se to takhle:

```
bundle exec fastlane bump_version
```

Fastlane zvýší číslo verze všude, kde je potřeba, a commitne.

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
        .foregroundColor(Color("colors/inactive"))
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
- Přidej překlad jazyku do `Localizable` -> `language.{x-x}`. 


## Lokalizace aplikace

- Používej anglický text (zjednodušená forma)
- Vyexportuj překlad `Product` -> `Export localizations` a nech výsledek (dej to součástí repozitáře v rootu)
- Nezapomínej používat `comment` pro upřesnění kde se text nachází. Například: `Text("About us", comment: "About us in menu")` nebo `String(localized: "About us", comment" About us in menu")`
- Překladatel pak překladá / upravue soubory v `Movapp Localizations/X.xcloc`
    - Movapp--iOS--InfoPlist
        - CFBundleDisplayName -> zde je název aplikace co se zobrazuje uživateli na ploše apod
        - NSHumanReadableCopyright -> Copyright
    - Shared -> Resources -> Localizable -> Zde jsou všechny použíté řetezce v aplikaci
    - WatchMovapp WatchKit Extension -> stejné parametry jako v Movapp--iOS--InfoPlist ale pro Watch aplikaci
- Po přeložení vložit do repozitáře a následně programátor importuje přes `Product -> Import localizations`.
- Lze taky lokalizovat bez exportu lokalizací přímo v Shared -> Resources -> x.lproj -> X 


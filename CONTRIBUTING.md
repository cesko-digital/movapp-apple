# Přidej se k vývoji Movapp na Apple zařízení

- [Správa slovíček](translations/README.md)

# Git

- Používejte rebase politiku (vždy vycházejte z `main`)
- Před mergem vždy rebasnete nad `main` a vyřešíte konflitky
- Pro vložení do `main` se provede squash commit a nebo si lokálně upravte komity

# Verzování

Používáme schéme `x.y.z`, kde změny `z` znamenají pouze interní releasy, například nové testovací verze pro interní tým, `y` se zvedá při posílání nové verze do App Storu a `x` si necháváme v záloze pro zásadnější změny.

# Fastlane

Pro automatizaci releasů a souvisejících procesů používáme [Fastlane](https://fastlane.tools). Samotnou Fastlane můžete nainstalovat buď přes `brew install fastlane`, nebo lépe přímo v repository příkazem `bundle`. Ta lokální instalace v repu je lepší v tom, že všichni používáme stejnou verzi. Dál počítáme s tím, že jste Fastlane nainstalovali takhle. Pokud ne, pište místo `bundle exec fastlane` prostě jen `fastlane`.

# Podepisování

Pro podepsání kódu jsou potřeba certifikáty a profily, které se dají stáhnout přes Fastlane:

```
bundle exec fastlane match development --readonly
```

# Releasing

Během vývoje přidávejte informace o novinkách do souboru `CHANGELOG.md` do sekce `[Unreleased]`. Pokud v ní před releasem ještě něco chybí, doplňte a commitněte. Pak vyrobíte nový release přes Fastlane:

```
bundle exec fastlane release # 1.2.1 → 1.2.2
```

Tohle standardně vyrobí „patch release“, tedy zvedne poslední číslo verze. Pokud chcete zvýšit prostředí číslo verze, vypadá to takhle:

```
bundle exec fastlane release type:minor # 1.2.1 → 1.3.0
```

Fastlane zvýší číslo verze všude, kde je potřeba, aktualizuje changelog a vyrobí nový tag v Gitu.

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



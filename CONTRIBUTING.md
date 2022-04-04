# Přidej se k vývoji Movapp na Apple zařízení

- [Správa slovíček](translations/README.md)

# Verzování

Používáme schéme `x.y.z`, kde změny `z` znamenají pouze interní releasy, například nové testovací verze pro interní tým, `y` se zvedá při posílání nové verze do App Storu a `x` si necháváme v záloze pro zásadnější změny.

# Fastlane

Pro automatizaci releasů používáme [Fastlane](https://fastlane.tools). Samotnou Fastlane můžete nainstalovat buď přes `brew install fastlane`, nebo lépe přímo v repository příkazem `bundle`. Ta lokální instalace v repu je lepší v tom, že všichni používáme stejnou verzi. Dál počítáme s tím, že jste Fastlane nainstalovali takhle. Pokud ne, pište místo `bundle exec fastlane` prostě jen `fastlane`.

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


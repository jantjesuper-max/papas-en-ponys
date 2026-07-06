# Changelog

Alle noemenswaardige wijzigingen aan Papa & Pony's worden hier bijgehouden.
Het format volgt [Keep a Changelog](https://keepachangelog.com/nl/1.1.0/).

## [Unreleased]

## [0.6.0] - 2026-07-06

### Toegevoegd
- Vlechtworkshop-landingspagina flink uitgebreid: krantenartikel-sectie ("35 vaders leerden vlechten"), stappenplan "Zo werkt zo'n avond", introzin en badges in de hero, en een meenemen-regel in de infokaart
- Krantenfoto toegevoegd aan `fotos/` en verwerkt als krantenknipsel met papier-effect

### Gewijzigd
- Alle sfeerfoto's uit `fotos/` staan voortaan op elke vlechtworkshop-pagina; andere evenementen tonen alleen hun eigen geüploade foto's
- Inschrijven is voortaan per papa: de aantal-selector is verwijderd uit beide inschrijfformulieren; vrienden schrijven zich los in
- Fotoraster vult een onvolle laatste rij nu netjes met een brede foto

## [0.5.0] - 2026-07-06

### Toegevoegd
- `evenement.html`: deelbare landingspagina per evenement (`evenement.html?id=…`) met fotogalerij, praktische-infokaart, kopieer-link- en WhatsApp-deelknoppen en een inline inschrijfformulier
- Foto-upload per evenement in het beheer: meerdere foto's tegelijk, automatische verkleining (max 1200px), thumbnails met verwijderknop
- Nette "niet gevonden"- en "al geweest"-varianten op de evenementpagina
- 🔗-knop in het beheer om de landingspagina van een evenement direct te openen
- Evenementtitels en "meer info"-links op de homepage verwijzen naar de landingspagina
- Evenementen zonder eigen foto's tonen automatisch sfeerfoto's van eerdere avonden
- Waarschuwing in het beheer wanneer de browseropslag vol raakt
- Twee evenementtypes als tags: 🎀 vlechtworkshop en 🎪 ander evenement — te kiezen in het beheer, zichtbaar op de homepage en de evenementpagina
- Vlechtworkshop-pagina's krijgen een eigen feestelijke hero (roze verloop + geanimeerd vlechtje) als basis voor een grootsere workshoppagina later
- Bestaande evenementen zonder type krijgen er automatisch één op basis van hun categorie

## [0.4.0] - 2026-07-06

### Toegevoegd
- Map `fotos/` met vier foto's van workshopavonden (hernoemd naar web-veilige bestandsnamen)
- Echte workshopfoto in de hero-kaart, met de geanimeerde vlecht-illustratie als accent eronder
- Nieuwe sectie "Zo ziet zo'n avond eruit" met drie sfeerfoto's, bijschriften en hover-effect
- Alt-teksten en lazy loading voor alle nieuwe afbeeldingen

## [0.3.0] - 2026-07-06

### Toegevoegd
- `README.md` met projectoverzicht, lokale-ontwikkelinstructies en uitleg over de localStorage-datalaag
- Deze changelog

## [0.2.0] - 2026-07-06

### Toegevoegd
- `.gitignore` die het GitHub-token, `.env`-bestanden en zip-backups buiten de repo houdt
- `push-naar-github.ps1`: pushen naar GitHub met het token uit `github-token.txt`, zonder het token ergens op te slaan
- Lokale git-repo gekoppeld aan [jantjesuper-max/papas-en-ponys](https://github.com/jantjesuper-max/papas-en-ponys)

## [0.1.0] - 2026-07-06

### Toegevoegd
- Landingspagina (`index.html`): hero met geanimeerde vlecht-SVG, missie, "Wat we doen", waarden, evenementenoverzicht en aanmeldformulier voor de WhatsApp-community
- Beheeromgeving (`admin/index.html`): evenementen aanmaken/bewerken/verwijderen, inschrijvingen per evenement, WhatsApp-aanmeldingen beheren en CSV-export
- Dataopslag via localStorage met seed-evenementen bij eerste bezoek

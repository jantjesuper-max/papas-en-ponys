# Changelog

Alle noemenswaardige wijzigingen aan Papa & Pony's worden hier bijgehouden.
Het format volgt [Keep a Changelog](https://keepachangelog.com/nl/1.1.0/).

## [Unreleased]

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

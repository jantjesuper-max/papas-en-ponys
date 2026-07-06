# Changelog

Alle noemenswaardige wijzigingen aan Papa & Pony's worden hier bijgehouden.
Het format volgt [Keep a Changelog](https://keepachangelog.com/nl/1.1.0/).

## [Unreleased]

## [0.12.1] - 2026-07-06

### Toegevoegd
- Subtiele micro-animaties, met respect voor `prefers-reduced-motion`:
  - de pony in het logo wiebelt af en toe even (pauzeert bij hover)
  - glans-sweep over gouden knoppen bij hover
  - waarden-chips poppen een voor een op als de sectie in beeld komt
  - kloppend hartje 💛 in de footer
  - fotobijschriften in de sfeersectie tillen iets op bij hover
  - hero-badges op de vlechtworkshop-pagina komen een voor een op
  - zachte aandacht-puls op de betaalknop
  - statistiek-cijfers in het beheer tellen bij het openen zachtjes op

## [0.12.0] - 2026-07-06

### Toegevoegd
- Naam is overal gesplitst in voornaam + achternaam (evenement-inschrijving, homepage-modal, WhatsApp-aanmelding, beheer); oude records met één naamveld worden automatisch gesplitst op de eerste spatie
- Extra velden bij evenement-inschrijvingen: woonplaats en leeftijd dochter(s) (beide optioneel), zichtbaar in het beheer en in de Excel-export
- Extra velden bij WhatsApp-aanmelding: e-mailadres en woonplaats (beide optioneel), zichtbaar in het beheer en de CSV-export
- Contactsectie is een volledig formulier geworden (voornaam, achternaam, e-mail, onderwerp, bericht) dat het mailprogramma opent met alles ingevuld
- Excel-export heeft nu kolommen Voornaam, Achternaam, Woonplaats en Leeftijd dochters

## [0.11.0] - 2026-07-06

### Toegevoegd
- Prijs per evenement: in te vullen in het beheer, zichtbaar op de homepage-kaart, in de hero en de infokaart van de evenementpagina ("€7,50 per papa", leeg = "gratis")
- Betaallink per evenement (Tikkie, bankbetaalverzoek of Mollie/Stripe payment link): gouden betaalknop in de infokaart én in het bevestigingsscherm na inschrijving ("Rond je inschrijving af")
- Betaald-status per inschrijving in het beheer: 💶-knop om af te vinken, pill "betaald"/"nog niet betaald", teller per evenement (bijv. "3/5 betaald") en een Betaald-kolom in de Excel-export
- Alleen http(s)-betaallinks worden gerenderd (veiligheidsmaatregel)

## [0.10.0] - 2026-07-06

### Toegevoegd
- Inschrijvingen toevoegen in het beheer: formulier met evenement-keuze, naam, e-mail, telefoon, dochter(s) mee en opmerking — voor papa's die zich telefonisch of persoonlijk aanmelden
- Inschrijvingen bewerken via een ✏️-knop per inschrijving; oude records met één contactveld worden automatisch in het juiste vak gezet (e-mail of telefoon)

### Gewijzigd
- Inschrijvingen-tab heeft nu dezelfde indeling als de andere tabs: formulier links, lijst rechts

## [0.9.0] - 2026-07-06

### Toegevoegd
- Tabblad "Sjablonen" in het beheer: mailsjablonen aanmaken, bewerken en verwijderen (opslag in `pp_mail_sjablonen`)
- Dynamische velden in sjablonen: {naam}, {evenement}, {datum}, {tijd}, {locatie}, {categorie}, {beschrijving} en {link} — klikbare chips voegen ze in op de cursorpositie
- Twee voorbeeldsjablonen: "Herinnering: over 2 weken" en "Naslagwerk na de bijeenkomst" (met link naar de foto's op de evenementpagina)
- Mailknoppen zijn keuzemenu's geworden: bij hover kies je "Leeg — zonder sjabloon" of een sjabloon; velden worden automatisch ingevuld met de evenementgegevens

### Gewijzigd
- {naam} wordt in groepsmails "papa's" (BCC kan niet per ontvanger personaliseren)

## [0.8.1] - 2026-07-06

### Toegevoegd
- `CLAUDE.md`: technisch projectoverzicht met architectuur, localStorage-datamodel, huisstijl-afspraken, valkuilen (o.a. gedupliceerde seeds, opslaglimiet, Pages-storingen) en werkwijzen voor wijzigen, testen en deployen
- Documentatie in de code: bestandskoppen in alle drie de HTML-bestanden, scriptoverzichten bovenaan elk `<script>`-blok en toelichting bij de foto-verkleining, opslag-quota-afvang, Excel-export en mailfuncties
- README verwijst nu naar CLAUDE.md en de changelog

## [0.8.0] - 2026-07-06

### Toegevoegd
- Oprichterssectie "De oprichter" onderaan de homepage: foto in wit kader met roze accent, bio van Faizi (docent, goochelaar, voorleesvader, kinderboekenschrijver en papa van twee dochters) en links naar De Spelende Mens, LinkedIn en Instagram (@devoorleesvader)
- Contactsectie helemaal onderaan: donkere kaart in huisstijl met mailknop naar jantje.super@gmail.com
- Navigatie bijgewerkt: "Over Faizi" en "Contact" vervangen "Wat we doen"

### Verwijderd
- Sectie "Wat we doen" op de homepage (inclusief bijbehorende stijlen)

## [0.7.0] - 2026-07-06

### Toegevoegd
- Inschrijfformulieren vragen nu een e-mailadres én telefoonnummer (beide verplicht), op de evenementpagina en in het homepage-modal
- "📧 Mail alle deelnemers"-knop in het beheer: opent je mailprogramma met alle unieke adressen in de BCC, zodat iedereen los van elkaar een mail krijgt en niemand elkaars adres ziet
- Mailknop per evenement in de inschrijvingenlijst
- Excel-export in huisstijl vervangt de CSV voor inschrijvingen: titelbalk, gekleurde kopregels, om-en-om rijkleuren, gegroepeerd per evenement, en klikbare "Mail alle deelnemers"- en "Mail deze groep"-links (BCC) in het bestand zelf

### Gewijzigd
- Beheer toont e-mail en telefoon apart per inschrijving; oude inschrijvingen met één contactveld blijven gewoon zichtbaar

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

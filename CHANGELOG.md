# Changelog

Alle noemenswaardige wijzigingen aan Papa & Pony's worden hier bijgehouden.
Het format volgt [Keep a Changelog](https://keepachangelog.com/nl/1.1.0/).

## [Unreleased]

## [0.23.0] - 2026-07-23

### Toegevoegd
- Opmaakbalk boven het verhaal-veld in de blogtab: vet, cursief, onderstrepen, markeren, tussenkopjes (H2/H3), opsomming, genummerde lijst, citaat, link, foto invoegen en scheidingslijn — de knoppen zetten opmaaktekens om de selectie heen
  - Het verhaal ondersteunt nu `**vet**`, `*cursief*`, `__onderstreept__`, `==markeren==`, `[tekst](https://...)`-links (alleen http(s)), `- ` opsommingen, `1. ` genummerde lijsten, `> ` citaten, `---` scheidingslijnen en `### ` kleine kopjes; gerenderd door `verhaalHtml()`/`inlineOpmaak()` (gedupliceerd in blogpost.html én het beheer)
- Foto's midden in het verhaal: de 📷-knop in de opmaakbalk voegt `[foto:N]` in (kies uit de geüploade foto's); die foto verschijnt op die plek in het verhaal en wordt niet nóg eens onderaan herhaald
- Voorbeeld bekijken vóór publicatie:
  - 👁️ Voorbeeld-knop in het blogformulier: modal die het bericht (ook ongeopslagen wijzigingen) rendert zoals op de echte blogpagina
  - 👁️-knop bij concepten in de lijst: opent `blogpost.html?voorbeeld=<id>` — de échte landingspagina in voorbeeldmodus, met conceptbanner en noindex; concepten blijven voor bezoekers onvindbaar

## [0.22.0] - 2026-07-23

### Toegevoegd
- Blog: papa's uit de community kunnen verhalen publiceren op de site
  - Nieuwe pagina `blog.html` (overzicht van alle gepubliceerde berichten, nieuwste eerst; het nieuwste bericht krijgt een brede uitgelichte kaart) en `blogpost.html?b=<slug>` (landingspagina per bericht met kop-foto, tussenkopjes, auteurskaart, deelknoppen en "Lees ook")
  - Nieuwe localStorage-sleutel `pp_blogs`; twee meegeleverde seed-berichten (gedupliceerd in blog.html, blogpost.html én het beheer — zelfde patroon als de evenement-seeds)
  - Nieuwe beheertab "✍️ Blog": berichten schrijven/bewerken/verwijderen, foto-upload (eerste foto = kop-foto), publicatiedatum en een gepubliceerd/concept-schakelaar; opmaak via lege regels (alinea's) en `## ` (tussenkopjes)
  - "Blog" in de menubalk van de homepage en in de footers; blog.html heeft dezelfde menubalk als de homepage met Blog als actieve pagina
  - SEO: Blog-schema (JSON-LD) op het overzicht, BlogPosting-schema + dynamische title/description/canonical/OG per bericht, noindex bij onbekende of concept-berichten; blog.html en de seed-slugs in sitemap.xml
- Accountrollen in het beheer: nieuw veld `rol` op beheerdersaccounts — "beheerder" (alles, ook accounts zonder het veld) of "blogger" (alleen blogs schrijven)
  - Een blogger ziet na het inloggen alleen de Blog-tab en kan alleen eigen berichten bewerken, verwijderen of publiceren (match op auteur); beheerders mogen alle berichten beheren
  - De rol staat als pill in de beheerderslijst en in de header ("✍️ blogger"); de laatste beheerder kan niet worden verwijderd of naar blogger worden omgezet

## [0.21.0] - 2026-07-23

### Toegevoegd
- Adresveld per evenement ("Adres (voor Google Maps)", nieuw veld `adres`): de locatie op de evenementpagina (hero en info-kaart) is nu een klikbare Google Maps-link — met adres wijst die precies goed, zonder adres zoekt Maps op de locatienaam. Adres ook als `streetAddress` in het Event-schema en als nieuw sjabloonveld `{adres}`
- Na het inschrijven kun je het evenement direct in je agenda zetten: knoppen "📅 Zet in Google Agenda" en "⬇ Agenda-bestand (.ics)" (Apple/Outlook) in het succesbericht van de evenementpagina én de homepage-modal
  - Eendaags evenement met tijd → afspraak van 2 uur; meerdaags of zonder tijd → hele dag(en); locatie/adres en een link naar de evenementpagina gaan mee
  - De homepage-modal sluit na inschrijven niet meer automatisch, zodat je de agenda-knoppen kunt aanklikken
- De menubalk van de evenementpagina heeft een "Inschrijven"-knop die direct naar het inschrijfformulier springt (alleen zichtbaar zolang het evenement nog moet komen)

### Opgelost
- De "Word lid"-knop in de menubalk kon bij smallere schermen worden samengedrukt waardoor de tekst buiten de knop viel; knoppen krimpen niet meer (alle pagina's)

## [0.20.0] - 2026-07-23

### Toegevoegd
- De homepage-evenementenlijst heeft twee schakelknoppen: "📅 Aankomend" (standaard) en "📸 Geweest"
  - Bij "Geweest" staan de eerdere evenementen (nieuwste eerst) met een "terugblik →"-link naar de landingspagina; heeft het evenement een fotoalbum-link, dan staat er ook een knop "📸 Bekijk foto's" — zo kan iedereen via de landingspagina bij de foto's
  - Bij eerdere evenementen verdwijnt de inschrijfknop; kop en introtekst wisselen mee ("Eerdere evenementen")
  - Het ItemList-schema (SEO) blijft alleen de aankomende evenementen bevatten

## [0.19.0] - 2026-07-23

### Toegevoegd
- Evenementen kunnen meerdaags zijn: nieuw optioneel veld `datumTot` ("Datum van/tot" in het beheer; leeg = eendaags)
  - Homepage-kaart, inschrijfmodal, evenementpagina (hero, info-kaart), beheerlijsten, mailsjabloonveld `{datum}` en de Excel-export tonen het bereik ("14 t/m 16 augustus 2027")
  - Een meerdaags evenement telt pas als "voorbij" wanneer de einddatum voorbij is (helper `eindDatum(e)`, gedupliceerd in alle drie de pagina's); het beheer weigert een einddatum vóór de startdatum
  - Event-schema (JSON-LD) krijgt een `endDate`; inschrijvingen denormaliseren `eventDatumTot`
- Eigen inschrijfvragen per evenement: nieuw veld `vragen` (`{id, tekst, verplicht}`), te beheren in het evenementformulier ("➕ Vraag toevoegen", per vraag een verplicht-vinkje)
  - De vragen verschijnen als extra velden in alle drie de inschrijfformulieren (homepage-modal, evenementpagina, beheer); verplichte vragen blokkeren het versturen tot ze zijn ingevuld
  - Antwoorden worden met de vraagtekst op de inschrijving opgeslagen (`antwoorden`), zijn zichtbaar bij Inschrijvingen in het beheer en komen als extra kolommen per evenement terug in de Excel-export
- Fotoalbum-link per evenement: nieuw veld `fotoalbum` (bijv. een gedeeld Google Foto's-album)
  - Is het evenement geweest, dan verandert de inschrijfknop op de evenementpagina in "📸 Bekijk de foto's" (hero én info-kaart) met deze link; alleen http(s)-links worden gerenderd
  - Nieuw sjabloonveld `{fotoalbum}` voor bijvoorbeeld naslag-mails; de betaalknop verdwijnt bij afgelopen evenementen

## [0.18.0] - 2026-07-22

### Toegevoegd
- Het beheer zit nu achter een inlogscherm met beheerdersaccounts (nieuwe localStorage-sleutel `pp_beheerders`)
  - Eerste inlog op een apparaat: gebruikersnaam `faizi`, wachtwoord `PapaPonys2026!` — wijzig dat wachtwoord direct na de eerste keer inloggen
  - Nieuwe tab "🔐 Beheerders": accounts aanmaken, bewerken (naam/gebruikersnaam/wachtwoord resetten) en verwijderen; jezelf of de laatste beheerder verwijderen kan niet
  - Wachtwoorden worden nooit leesbaar opgeslagen, alleen als SHA-256-hash met salt per account (Web Crypto); de sessie staat in sessionStorage en verloopt zodra de browser sluit
  - Header toont wie er is ingelogd, met uitlogknop
  - Bewust benoemd in de UI en de code: dit is een client-side slot (er is geen server) — het houdt meekijkers buiten, maar is geen echte beveiliging
- Audit-velden: evenementen krijgen `aangemaaktDoor` (zichtbaar in de evenementenlijst), en het afvinken van een betaling legt `betaaldDoor` + `betaaldOp` vast (zichtbaar bij de inschrijving en in de Excel-export; terugdraaien wist de velden weer)
  - Dit zijn administratieve velden — bewust niet toegevoegd aan de mailsjablonen, die zijn voor mails aan deelnemers

## [0.17.0] - 2026-07-22

### Toegevoegd
- GitHub Actions-workflow `.github/workflows/deploy.yml`: pusht bij elke wijziging op `main` de site automatisch via FTPS naar Strato-webhosting
  - Vereist drie repo-secrets: `STRATO_SERVER`, `STRATO_GEBRUIKER` en `STRATO_WACHTWOORD`; zolang die ontbreken wordt de deploy netjes overgeslagen (geen mislukte runs)
  - Uploadt alleen gewijzigde bestanden en laat serverbestanden zoals `api/config.php` en `uploads/` met rust; token, scripts en documentatie worden nooit meegestuurd
  - Ook handmatig te starten via de Actions-tab (workflow_dispatch)
- `Stappenplan-Strato-hosting.docx`: compleet stappenplan om de site bij Strato te hosten met MySQL-database (pakketkeuze, bestelopties, databaseschema, PHP-backend, ombouw van localStorage naar API, kosten en checklist)

## [0.16.1] - 2026-07-22

### Gewijzigd
- Het vinkje "Dochters mogen mee 🎀" staat bij een nieuw evenement standaard **uit**: de beheerder vinkt het bewust aan als dochters welkom zijn (bestaande evenementen van vóór dit veld blijven dochters toestaan)

## [0.16.0] - 2026-07-22

### Toegevoegd
- Per evenement kan de beheerder aanvinken of dochters mee mogen ("Dochters mogen mee 🎀", nieuw veld `dochtersWelkom`)
  - Mogen dochters mee, dan tonen de inschrijfformulieren (homepage-modal, evenementpagina en beheer) het vinkje "Dochter(s) mee" plus een veld voor hoeveel dochters en hoe oud; zo niet, dan verdwijnen die vragen en wordt `dochterMee: false` opgeslagen
  - Evenementpagina toont bij "voor wie" nu "dochters van harte welkom" of "alleen papa's — dit keer zonder dochters"; bij vlechtworkshops zonder dochters vervalt de "geduldige dochter" uit de meeneemlijst
  - Evenementenlijst in het beheer toont per evenement "🎀 dochters mee" of "👨 alleen papa's"
  - Nieuw sjabloonveld `{dochters}` ("dochters zijn van harte welkom" / "dit keer zonder dochters")
  - Bestaande evenementen zonder het veld blijven dochters toestaan (geen gedragswijziging)

## [0.15.0] - 2026-07-07

### Toegevoegd
- `word-lid.html`: losse deelbare pagina voor WhatsApp-aanmeldingen en contact, om direct naar geïnteresseerde papa's te sturen
  - Hero met nagebouwde WhatsApp-kanalenlijst (Welkom & Voorstellen, Vlechten & Haar, Algemeen, Zelfontwikkeling, Playdates & Events, Verhalen & Anekdotes, Opvoeding & Dagelijkse Praktijk, Seksuele Voorlichting) met omschrijving per kanaal en "er komen steeds meer kanalen bij" — bewust als design-element in plaats van de screenshot, want daar staan telefoonnummers op (huisregel 2)
  - Drie uitlegkaarten over wat de groep inhoudt, met link naar de huisregels
  - Podcast-teaser: vanuit de community wordt aan een Papa & Pony's podcast gewerkt
  - WhatsApp-aanmeldformulier (zelfde opslag als de homepage, dus zichtbaar in het beheer) en contactformulier
  - "Deel deze pagina"-knop die de link kopieert; SEO-tags en opgenomen in de sitemap
- Homepage linkt vanuit de community-sectie naar de deelpagina

## [0.14.0] - 2026-07-07

### Toegevoegd
- Volledige technische SEO-laag:
  - `robots.txt` (admin uitgesloten) en `sitemap.xml` met de evenement-slug-URL's
  - Canonical-, Open Graph- en Twitter-tags op alle publieke pagina's, met absolute foto-URL als social preview
  - Organization- en WebSite-schema (JSON-LD) op de homepage, inclusief oprichter met links
  - Dynamisch **Event-schema** per evenementpagina (naam, datum+tijd, locatie, prijs in euro's, foto's, organisator) — hiermee kan Google evenementen als rich results tonen
  - ItemList-schema van aankomende evenementen op de homepage
  - Per evenement dynamische title met datum, meta description en canonical op de slug-URL; onbekende evenementen krijgen noindex
  - Nette 404-pagina in huisstijl (`404.html`)
  - Homepage-title en -description aangescherpt op de zoekwoorden vlechtworkshop/meisjespapa's; herofoto krijgt laadprioriteit

## [0.13.1] - 2026-07-06

### Toegevoegd
- Mooie evenement-URL's op basis van de titel: `evenement.html?e=vlechtworkshop-de-basisvlecht`; oude `?id=`-links blijven werken en worden in de adresbalk herschreven naar de slug
- Sjabloonvelden {voornaam} en {achternaam}; de sjabloon-{link} gebruikt nu ook de nette slug-URL
- Afspraken in CLAUDE.md: sjablonen groeien mee met nieuwe velden, en unieke evenementtitels vanwege de slugs

### Opgelost
- Akkoord-vinkje bij de voorwaarden brak lelijk af over meerdere regels; de tekst loopt nu netjes door als één zin

## [0.13.0] - 2026-07-06

### Toegevoegd
- `voorwaarden.html`: algemene voorwaarden in huisstijl met de gedragsplicht (te allen tijde netjes en respectvol), de zes huisregels van de community, de betaalverplichting bij aanmelding voor evenementen en een slotbepaling over ingrijpen door het beheer
- Verplicht akkoord-vinkje met link naar de voorwaarden in het WhatsApp-formulier en beide evenement-inschrijfformulieren; het akkoord wordt vastgelegd op het record (`voorwaardenAkkoord`)
- "Voorwaarden"-link in de footer van de homepage en de evenementpagina

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

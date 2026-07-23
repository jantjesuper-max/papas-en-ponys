# CLAUDE.md — Papa & Pony's

Gids voor het werken aan dit project (voor Claude Code én menselijke ontwikkelaars).

## Wat is dit project?

Community-website voor "meisjespapa's die leren vlechten". Statische site zonder frameworks, zonder build-stap en zonder server: pure HTML/CSS/JS, gehost op GitHub Pages via https://jantjesuper-max.github.io/papas-en-ponys/

## Bestandsoverzicht

| Bestand | Rol |
|---|---|
| `index.html` | Homepage: hero, missie, sfeerfoto's, evenementenlijst (schakelbaar tussen "Aankomend" en "Geweest" — bij eerdere evenementen geen inschrijfknop maar een terugblik/foto's-link naar de landingspagina), waarden, WhatsApp-aanmelding, oprichter (Faizi), contact |
| `evenement.html` | Landingspagina per evenement via `?id=<event-id>`. Vlechtworkshops krijgen een uitgebreide variant (roze hero, krantensectie, stappenplan) |
| `admin/index.html` | Beheer, achter een client-side inlog (tab Beheerders beheert de accounts): evenementen CRUD + foto-upload, inschrijvingen bekijken/mailen/exporteren, WhatsApp-aanmeldingen |
| `voorwaarden.html` | Algemene voorwaarden: gedrag, de zes huisregels en de betaalverplichting. Verplicht akkoord-vinkje (`voorwaardenAkkoord: true` op het record) in het WhatsApp-formulier en beide inschrijfformulieren |
| `word-lid.html` | Losse deelbare aanmeldpagina: uitleg over de WhatsApp-community, nagebouwde kanalenlijst (bewust géén screenshot — daar staan telefoonnummers op), podcast-teaser, WhatsApp-aanmeldformulier (zelfde `pp_wa_signups`) en contactformulier |
| `fotos/` | Sfeerfoto's (web-veilige kebab-case namen). Worden getoond op vlechtworkshop-pagina's en de homepage |
| `push-naar-github.ps1` | Pusht naar GitHub met het token uit `github-token.txt` |
| `github-token.txt` | GitHub-token (fine-grained PAT). **In `.gitignore`, nooit committen** |
| `CHANGELOG.md` | Wijzigingsgeschiedenis (Keep a Changelog). Bij elke feature bijwerken |
| `robots.txt` / `sitemap.xml` | SEO: admin uitgesloten, sitemap met homepage, voorwaarden en de evenement-slug-URL's. **Nieuw evenement dat lang vindbaar moet zijn? Voeg de slug-URL toe aan sitemap.xml** |
| `404.html` | Nette 404 in huisstijl (GitHub Pages serveert deze automatisch), noindex |

## Architectuur & datamodel

**Alles draait op localStorage** — er is geen backend. De drie pagina's delen dezelfde sleutels:

| Sleutel | Inhoud |
|---|---|
| `pp_events` | Array van evenementen |
| `pp_event_signups` | Array van inschrijvingen |
| `pp_wa_signups` | Array van WhatsApp-aanmeldingen |
| `pp_mail_sjablonen` | Array van mailsjablonen: `{id, naam, onderwerp, tekst}` met dynamische velden `{naam}`, `{voornaam}`, `{achternaam}`, `{evenement}`, `{datum}`, `{tijd}`, `{locatie}`, `{categorie}`, `{beschrijving}`, `{dochters}`, `{link}`, `{fotoalbum}` — ingevuld door `vulSjabloon()` in het beheer. `{datum}` toont bij een meerdaags evenement "van t/m tot". Bij groepsmail (BCC) worden `{naam}`/`{voornaam}` "papa's" en vervalt `{achternaam}` |
| `pp_beheerders` | Alleen gebruikt door het beheer (sinds v0.18): array van beheerdersaccounts `{id, naam, gebruikersnaam, salt, wachtwoordHash, aangemaaktOp, aangemaaktDoor}`. Wachtwoord = SHA-256(salt+":"+wachtwoord) via Web Crypto. Seed-account bij lege sleutel: `faizi` / `PapaPonys2026!`. Sessie in **sessionStorage** onder `pp_beheer_sessie`. **Let op: client-side slot, geen echte beveiliging** — broncode en localStorage zijn op het apparaat leesbaar |

### Vorm van een evenement

```js
{
  id: "ev-1712345678901",        // "seed-1..3" voor de meegeleverde voorbeelden
  titel: "Vlechtworkshop: ...",
  type: "vlechtworkshop" | "ander",  // bepaalt welke landingspagina-variant rendert
  datum: "2026-07-18",           // ISO, verplicht (startdatum; bepaalt sortering en de datumbadges)
  datumTot: "2026-07-19",        // sinds v0.19, optioneel: einddatum voor meerdaagse evenementen. Leeg/ontbreekt = eendaags. Helper eindDatum(e) (datumTot || datum) bepaalt in alle drie de pagina's of iets voorbij is; het beheer weigert een einddatum vóór de startdatum
  tijd: "10:00",                 // optioneel
  locatie: "...", categorie: "Workshop|Uitje|Borrel|Community|Anders",
  beschrijving: "...",
  dochtersWelkom: true|false,    // sinds v0.16; bepaalt of de inschrijfformulieren de dochtervelden tonen. Ontbreekt het veld (ouder evenement), dan geldt true — helper dochtersWelkom(e) in alle drie de pagina's
  uitgelicht: true|false,
  prijs: "7,50",                 // leeg = gratis; weergave altijd met €-prefix
  betaallink: "https://...",     // Tikkie/betaalverzoek/payment link; alleen http(s) wordt gerenderd
  fotoalbum: "https://...",      // sinds v0.19, optioneel: link naar extern fotoalbum (bijv. gedeeld Google Foto's-album). Is het evenement voorbij, dan toont evenement.html "📸 Bekijk de foto's" (hero + info-kaart) i.p.v. de inschrijfknop; alleen http(s) wordt gerenderd
  vragen: [{id:"vr-...", tekst:"Heb je allergieën?", verplicht:true}],  // sinds v0.19, optioneel: eigen inschrijfvragen. Helper evVragen(e) in alle drie de pagina's; de formulieren tonen ze als extra velden (verplicht → required)
  fotos: ["data:image/jpeg;base64,..."],  // door beheer geüpload, verkleind naar max 1200px
  aangemaaktDoor: "Faizi"        // sinds v0.18: naam van de ingelogde beheerder; blijft staan bij bewerken. Seeds/oudere evenementen missen het veld
}
```

### Vorm van een inschrijving

```js
{
  id: "in-<timestamp>",
  eventId, eventTitel, eventDatum,   // gedenormaliseerd zodat verwijderde evenementen leesbaar blijven
  eventDatumTot,                     // sinds v0.19: gedenormaliseerde einddatum ("" bij eendaags)
  voornaam, achternaam,              // sinds v0.12; `naam` blijft de gecombineerde weergavenaam
  naam,                              // "voornaam achternaam" — oudere records hebben alléén dit veld (splits op eerste spatie)
  email, telefoon,                   // sinds v0.7; oudere records hebben alleen `contact`
  woonplaats, dochterLeeftijden,     // optioneel, sinds v0.12
  personen: "1",                     // sinds v0.6 altijd "1" (inschrijven per papa); oude records kunnen 2/3 zijn
  dochterMee: true|false, opmerking,
  antwoorden: [{vraag:"Heb je allergieën?", antwoord:"..."}],  // sinds v0.19: antwoorden op de eigen inschrijfvragen van het evenement (vraagtekst gedenormaliseerd, zodat antwoorden leesbaar blijven als vragen wijzigen). Zichtbaar in het beheer en als extra kolommen per groep in de Excel-export
  betaald: true|false,               // handmatig afgevinkt in het beheer (stap 1 van betalingen)
  betaaldDoor: "Faizi", betaaldOp: ISO-string,  // sinds v0.18: wie het afvinkte en wanneer; worden gewist bij terugdraaien
  aangemeldOp: ISO-string
}
```

### Vorm van een WhatsApp-aanmelding

```js
{
  id: "wa-<timestamp>",
  voornaam, achternaam, naam,        // zelfde conventie als inschrijvingen
  telefoon, email, woonplaats,       // email + woonplaats optioneel, sinds v0.12
  dochters: "1|2|3|4 of meer",
  bericht, status: "nieuw|toegevoegd",
  aangemeldOp: ISO-string
}
```

## Belangrijke afspraken

- **Taal**: alles in het Nederlands — UI-teksten, functienamen (`verwijderFoto`, `mailDeelnemers`), comments en commitberichten.
- **Huisstijl**: CSS-variabelen bovenaan elk bestand (`--ink`, `--paper`, `--accent` oker, `--rose`). Fonts: Outfit (display) + IBM Plex Mono (labels/pills). Afgeronde hoeken, zachte schaduwen, emoji als iconen.
- **Elke pagina is zelfstandig**: eigen `<style>` en `<script>` inline, geen gedeelde bestanden. Gedeelde logica (zoals `evType()`, `eindDatum()`, `evVragen()`, seeds, `esc()`) is dus **gedupliceerd** — wijzig je die, wijzig het dan op alle plekken (zie valkuilen).
- **Toegankelijkheid**: `prefers-reduced-motion` respecteren, alt-teksten in het Nederlands, `aria-label`s op formuliervelden.
- **Changelog**: bij elke feature een versie-entry in `CHANGELOG.md` (semver-achtig, datum erbij).
- **Sjablonen groeien mee**: voeg je een veld toe aan (of wijzig je een veld van) inschrijvingen/contactpersonen of evenementen, werk dan óók de mailsjablonen bij: `SJABLOON_VELDEN` én `vulSjabloon()` in `admin/index.html`, de hint-tekst onder de veld-chips, en de sjablonenrij in dit document.
- **SEO**: elke publieke pagina heeft canonical + Open Graph-tags; homepage draagt Organization/WebSite-schema en een dynamische ItemList van evenementen; `evenement.html` zet per evenement dynamisch title (met datum), meta description, canonical en **Event-schema** (JSON-LD, voor Google rich results) via `zetSeo()`. Onbekende evenementen krijgen noindex. Bij structurele wijzigingen aan evenementvelden ook `zetSeo()` bijwerken.
- **Evenement-URL's**: de nette vorm is `evenement.html?e=<slug-van-titel>` (gemaakt door `slugify()`, gedupliceerd in alle drie de pagina's); `?id=` blijft als fallback werken en wordt via `history.replaceState` herschreven naar de slug. Let op: twee evenementen met exact dezelfde titel delen een slug — de eerste wint. Gebruik dus unieke titels.

## Valkuilen (echt lezen)

1. **Seeds staan op 3 plekken**: `seedEvents` in `index.html` én `evenement.html`, en de seed in `admin/index.html` onderaan ("Seed als leeg"). Wijzig je een seed, doe het overal.
2. **`evType(e)`-fallback**: evenementen van vóór de tags hebben geen `type`; de helper leidt hem af uit `categorie === "Workshop"`. Deze helper staat in alle drie de bestanden.
3. **localStorage is per browser/apparaat**: inschrijvingen van echte bezoekers op de live site komen NIET in het beheer van de eigenaar terecht. Voor centrale data is een backend nodig (bewuste keuze om die er nog niet te hebben).
4. **Opslaglimiet ±5MB**: foto-uploads worden verkleind (max 1200px, JPEG 0.78) en `save()` in het beheer vangt `QuotaExceededError` af met een toast.
5. **Excel-export is SpreadsheetML** (XML, `.xls`): geen echte VBA-macro mogelijk vanuit de browser; de "mailknoppen" in het bestand zijn `mailto:`-hyperlinks met BCC.
6. **GitHub Pages deploy kan sporadisch falen** met "Deployment failed, try again later" terwijl de build slaagt — GitHub-storing, geen codefout. Oplossing: lege commit pushen.
7. **Fine-grained token**: kan pushen en Actions/Pages lezen, maar géén repo-beschrijving/topics wijzigen of Pages-builds triggeren (403). Ook pusht het géén wijzigingen aan `.github/workflows/` zolang de repository-permissie "Workflows: Read and write" niet is aangezet op het token (remote rejected).
8. **Git-root**: de projectmap heeft een eigen repo; de home-map van de gebruiker is óók een git-repo — let op vanuit welke map je git-commando's draait.
9. **Beheer-inlog is per apparaat én client-side**: `pp_beheerders` leeft in localStorage, dus elke nieuwe browser begint weer met het seed-account (`faizi` / `PapaPonys2026!`) en zelf aangemaakte accounts bestaan alleen op dat apparaat. Het is een slot tegen meekijkers, geen echte beveiliging — wie devtools opent kan erlangs.

## Werkwijzen

### Wijziging maken en publiceren

```powershell
# 1. Bewerk de bestanden
# 2. Verifieer visueel (zie hieronder) en werk CHANGELOG.md bij
git add <bestanden>
git commit -m "Beschrijvend bericht in het Nederlands"
.\push-naar-github.ps1        # pusht met token; Pages deployt automatisch (~1 min)
```

### Verifiëren

Na UI-wijzigingen altijd een full-page screenshot maken (vaste afspraak met de eigenaar):

```powershell
npx -y playwright screenshot --full-page --viewport-size "1280,900" --wait-for-timeout 3000 "file:///C:/Users/JandeVriesKBenP/Claude/Projects/Papa & Pony's/index.html" screenshot.png
```

Voor gedrag (formulieren, localStorage, downloads): Playwright-script in Node dat de flows echt doorloopt — zie eerdere testpatronen; test tegen `file://`-URL's, localStorage wordt gedeeld tussen de pagina's, en ruim testdata op met `localStorage.clear()`.

### Deploy controleren

```powershell
# Laatste Actions-run bekijken (token uit github-token.txt als Bearer-header):
# GET https://api.github.com/repos/jantjesuper-max/papas-en-ponys/actions/runs?per_page=1
```

## Contact & externe links

- Eigenaar/contact: jantje.super@gmail.com
- Oprichter: Faizi (Mohammad Faizi Nazir) — despelendemens.com, LinkedIn `mohammad-faizi-nazir`, Instagram `@devoorleesvader`
- Repo: https://github.com/jantjesuper-max/papas-en-ponys

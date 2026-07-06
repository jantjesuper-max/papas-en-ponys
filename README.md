# 🐴 Papa & Pony's

**De community waar meisjespapa's leren vlechten, samen activiteiten doen en elkaar verder helpen.**

Een vrolijke, snelle one-page website met bijbehorende beheeromgeving — gebouwd zonder frameworks, zonder build-stap en zonder server. Gewoon openen en hij werkt.

## ✨ Wat zit erin

| Pagina | Bestand | Wat het doet |
|---|---|---|
| **Landingspagina** | [`index.html`](index.html) | Missie, activiteiten, waarden, aankomende evenementen en aanmelden voor de WhatsApp-community |
| **Evenementpagina** | [`evenement.html`](evenement.html) | Deelbare landingspagina per evenement (`evenement.html?id=…`) met foto's, praktische info, deelknoppen en inschrijfformulier |
| **Beheer** | [`admin/index.html`](admin/index.html) | Evenementen aanmaken en bewerken (incl. foto-upload), inschrijvingen per evenement bekijken, WhatsApp-aanmeldingen beheren en exporteren naar CSV |

### Hoogtepunten

- 🎨 **Eigen huisstijl** — warme okergele en roze tinten, Outfit + IBM Plex Mono, geanimeerde vlecht-illustratie in SVG
- 🗓️ **Evenementenbeheer** — de beheerpagina vult de evenementen op de landingspagina automatisch aan
- 🎟️ **Inschrijvingen** — bezoekers schrijven zich in voor evenementen; beheerders zien alles per evenement terug
- 💬 **WhatsApp-aanmeldingen** — aanmeldformulier op de site, beheer en CSV-export in de admin
- ♿ **Toegankelijk** — respecteert `prefers-reduced-motion`, semantische HTML, `noindex` op de beheerpagina

## 🚀 Lokaal draaien

Er is geen installatie nodig:

```
# Optie 1: dubbelklik op index.html

# Optie 2: met een lokaal servertje (aanrader, dan werkt alles identiek aan online)
npx serve .
```

## 🗄️ Hoe de data werkt

Alle gegevens (evenementen, inschrijvingen, WhatsApp-aanmeldingen) worden opgeslagen in **localStorage van de browser**. Dat betekent:

- Geen database of hosting-kosten, werkt overal direct
- Data leeft per browser/apparaat — de beheerpagina ziet alleen aanmeldingen die in *dezelfde browser* zijn gedaan
- Wil je aanmeldingen van echte bezoekers centraal ontvangen, dan is een backend (bijv. Firebase of een formulierdienst) de volgende stap

## 🛠️ Ontwikkelen

```powershell
# Wijzigingen committen
git add .
git commit -m "Beschrijving van je wijziging"

# Pushen naar GitHub (leest je token uit github-token.txt, zie .gitignore)
.\push-naar-github.ps1
```

> ⚠️ `github-token.txt` staat in [`.gitignore`](.gitignore) en hoort **nooit** in de repo terecht te komen.

## 📋 Meer documentatie

- [CHANGELOG.md](CHANGELOG.md) — volledige wijzigingsgeschiedenis per versie
- [CLAUDE.md](CLAUDE.md) — technisch overzicht: architectuur, datamodel, afspraken en valkuilen (voor ontwikkelaars en AI-assistenten)

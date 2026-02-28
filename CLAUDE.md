# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Branch Structure

| Branch | Purpose |
|--------|---------|
| `main` | Only holds `CNAME` for DNS (`www.sabir.com.np`) |
| `gh-pages` | Static build output served by GitHub Pages |
| `vue` | Active development branch — Vue 3 app |

**Development happens on the `vue` branch.** Switch there before making any changes.

## Tech Stack (vue branch)

- **Vue 3** (Composition API) + **Vite** + **Bootstrap 5**
- **vue-router** for client-side routing
- **Chart.js** via vue-chartjs, **Swiper**, **FontAwesome**
- **Sass** for styles (`src/scss/`)
- Content is data-driven: JSON files in `public/data/` control all text, sections, and settings

## Commands

```bash
make install  # npm install - Install dependencies
make run      # npm run dev — starts Vite dev server
make build    # build + copy index.html → 404.html in dist/
make deploy   # build, force-add dist/, commit, push vue branch, then subtree push dist/ → gh-pages
```

Or directly:
```bash
npm run dev
npm run build
npm run deploy   # copies index.html to 404.html (fixes 404 on route reload for GitHub Pages)
```

## Project Structure (vue branch)

```
public/
  data/
    settings.json     # preloader toggle, supported languages
    sections.json     # section order, component mapping, icons
    strings.json      # all i18n strings
    sections/         # per-section JSON content files
    info/             # personal info JSON
  images/
src/
  vue/
    core/             # app shell components
    sections/         # section-level Vue components (TimelineSection, etc.)
    navigation/       # sidebar + mobile nav
    feedbacks/        # contact form, spinners
    widgets/          # reusable UI widgets
    constants.js      # app-wide constants
    data.js           # data loading / access helpers
    language.js       # i18n logic
    layout.js         # layout state
    navigation.js     # nav state
    utils.js
  composables/        # Vue composables
  router/router.js
  scss/               # global styles, _variables.scss for theme colors
  main.js
dist/                 # built output (committed to deploy)
```

## Content Customization

- **Sections**: edit `public/data/sections.json` — maps section `id` → Vue component → content JSON path
- **Text/i18n**: `public/data/strings.json` for global strings; section JSONs have their own `locales` field
- **Theme colors**: `src/scss/_variables.scss` (`$primary`, `$dark`, `$background-color`)
- **Languages**: `supportedLanguages` array in `public/data/settings.json`

## Deployment Flow

```
vue branch (dev) → npm run build → dist/ → git subtree push → gh-pages branch → GitHub Pages
```

The `make deploy` target handles this end-to-end. The `404.html` copy in `dist/` is required to prevent 404s on direct route access (GitHub Pages SPA workaround).

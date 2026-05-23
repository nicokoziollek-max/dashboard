# AGENTS.md — Nico's Project Hub

This file is the single source of truth for AI coding agents (Codex, Claude Code, etc.) working in this repository.

## Repository Overview

This monorepo contains three independent projects:

| Folder | What it is | Stack | Status |
|--------|-----------|-------|--------|
| `senftest/` | Instagram competitor & content dashboard | Python/FastAPI + Node.js/Express | Live |
| `nicodash/` | Personal business hub (finance, clients, tasks) | Pure HTML/CSS/JS | Live |
| `muellers-dach/` | Marketing website for a roofing company | Pure HTML/CSS/JS | Static |

---

## Quick Start

### SenfTest (Social Media Dashboard)
```bash
cd senftest
cp .env.example .env          # fill in your tokens
bash start.sh                  # starts backend (port 8000) + frontend (port 3000)
```
→ Open http://localhost:3000

### NicoDash (Personal Hub)
```bash
cd nicodash
npx serve -l 4000 .
```
→ Open http://localhost:4000

### Müllers Dach (Website)
```bash
cd muellers-dach
node server.js
```
→ Open http://localhost:3001

---

## Environment Variables

Each project that needs secrets has a `.env.example` file. Copy it to `.env` and fill in real values. **Never commit `.env` files.**

### senftest/.env
```
TELEGRAM_TOKEN=your_telegram_bot_token
TELEGRAM_CHAT_ID=your_chat_id
ANTHROPIC_API_KEY=your_anthropic_api_key
```

---

## Project Details

### senftest/
Full-stack Instagram analytics & content planning tool.

**Backend** (`senftest/backend/` — Python 3.11, FastAPI):
- `main.py` — API routes, Telegram reminder scheduler, DB migrations on startup
- `models.py` — SQLAlchemy ORM: `Influencer` → `Post` → `Draft`
- `database.py` — SQLite setup (file: `senftest.db`)
- `scraper.py` — Playwright-based Instagram scraper
- `thumbnails/` — Downloaded post images (gitignored, auto-populated by scraper)

**Frontend** (`senftest/frontend/` — Node.js/Express):
- `server.js` — Lightweight proxy: serves static files, forwards `/api` & `/thumbnails` to backend
- `public/index.html` — Single-page app shell
- `public/app.js` — ~3000 lines of vanilla JS (all UI logic)

**Key API endpoints:**
- `GET /api/influencers` — list tracked accounts
- `POST /api/influencers` — add new account
- `POST /api/scrape/{username}` — trigger scrape
- `GET /api/posts/{influencer_id}` — list posts
- `GET /api/drafts` — list content drafts
- `POST /api/drafts` — create draft

**Database schema:** Auto-migrated on startup. SQLite file at `senftest/backend/senftest.db`.

**Telegram integration:** Background thread sends reminders 60min and 15min before scheduled posts.

---

### nicodash/
Static multi-page personal dashboard. No backend, no build step, all data lives in `localStorage`.

Pages:
- `index.html` — Home / daily overview
- `finanzen.html` — Revenue, expenses, profit per month
- `clients.html` — Coaching clients, goals, payment status
- `outreach.html` — Sales pipeline & outreach tasks
- `salescall.html` — Call scripts and notes
- `weekly.html` — Weekly review and reflection

Everything is self-contained — just open the HTML files in a browser or serve them statically.

---

### muellers-dach/
Static one-page marketing website for a roofing company in Hilden, Germany.
- `index.html` — Complete site (inline CSS + JS)
- `server.js` — Minimal Node.js HTTP server for local preview

---

## Development Rules for AI Agents

1. **Python venv:** Use `senftest/backend/venv/` (Python 3.11). Activate with `source senftest/backend/venv/bin/activate` before running Python commands.
2. **No secrets in code:** Tokens and API keys go in `.env`, loaded via `os.environ.get(...)`.
3. **Database migrations:** Add new columns via the migration block at the top of `main.py` (try/except ALTER TABLE pattern already in use).
4. **Frontend:** No build tools. Vanilla JS only. Edit `public/app.js` directly.
5. **Thumbnails:** The `thumbnails/` directory contains 1500+ images. It is gitignored. The scraper repopulates it automatically.
6. **Language:** UI and comments are in German.
7. **Ports:** Backend 8000, SenfTest frontend 3000, NicoDash 4000, Müllers Dach 3001.

# Deployment

## Zielstruktur

- Hauptdashboard: `/`
- SenfTest: `/senftest/`
- API: `/api/...`

Live laufen dafuer zwei Services:

- `nico-dashboard`: Node/Express, liefert NicoDash und SenfTest aus.
- `nico-senftest-api`: Python/FastAPI, speichert und verarbeitet SenfTest-Daten.

## Render Setup

1. Repository zu GitHub hochladen.
2. In Render `New` -> `Blueprint` waehlen.
3. GitHub-Repository verbinden.
4. Render liest `render.yaml` und erstellt beide Services.
5. Beim Setup Environment Variables setzen:
   - `BACKEND_URL`: die URL vom API-Service, z.B. `https://nico-senftest-api.onrender.com`
   - `DATABASE_URL`: Postgres-Verbindung, z.B. Supabase oder Render Postgres
   - `TELEGRAM_TOKEN`: optional
   - `TELEGRAM_CHAT_ID`: optional
   - `ANTHROPIC_API_KEY`: optional
6. Deploy starten.

## Ohne Blueprint

Backend-Service:

- Runtime: Python
- Root Directory: `senftest/backend`
- Build Command: `pip install -r requirements.txt`
- Start Command: `uvicorn main:app --host 0.0.0.0 --port $PORT`

Frontend-Service:

- Runtime: Node
- Root Directory: leer lassen
- Build Command: `cd senftest/frontend && npm install`
- Start Command: `cd senftest/frontend && npm start`
- Environment Variable: `BACKEND_URL=https://deine-api-url.onrender.com`

## Datenbank

Lokal nutzt SenfTest SQLite. Live sollte `DATABASE_URL` auf Postgres zeigen, sonst sind Daten je nach Hosting nicht dauerhaft sicher.

Empfehlung:

- Supabase Postgres fuer dauerhafte Datenbank
- spaeter Supabase Auth fuer Login
- spaeter Supabase Storage fuer Thumbnails

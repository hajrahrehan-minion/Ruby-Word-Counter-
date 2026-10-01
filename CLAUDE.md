# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project state

`word_counter` is a deliberately beginner-friendly Rails 8.1 app with no database tables. `GET /` and `POST /` both go to `PagesController#home`, which builds a `TextStats` (plain Ruby class in `app/models/`) from `params[:text]` and renders `home.html.erb`. The form is a plain HTML form (no Turbo, no JavaScript), so rendering a 200 page from a POST works. Keep it simple: the user asked for the app to be as plain as possible, so avoid JavaScript, partials, extra actions, or clever regexes.

`assignment/` is the user's Ruby learning exercise (skeleton `word_counter.rb`, grader `check.rb`, prompts in `CHECKPOINTS.md`). It's not part of the app. Don't fill in the skeleton or hand out solutions; the user works through it checkpoint by checkpoint.

## Commands

```bash
bin/setup                 # install gems, prepare DB, start server (add --skip-server to skip)
bin/dev                   # run the dev server
bin/ci                    # full local CI pipeline (defined in config/ci.rb)

bin/rails test                                   # unit/integration tests
bin/rails test test/models/foo_test.rb           # single file
bin/rails test test/models/foo_test.rb:42        # single test by line
bin/rails test:system                            # system tests (Capybara + Selenium/Chrome)

bin/rubocop               # lint (rubocop-rails-omakase style); -a to autocorrect
bin/brakeman --no-pager   # security static analysis
bin/bundler-audit         # gem vulnerability audit
```

`bin/ci` runs: setup → rubocop → bundler-audit → brakeman (fails on warnings) → `bin/rails test` → `db:seed:replant` in test env. GitHub Actions (`.github/workflows/ci.yml`) runs the same checks as separate jobs.

## Architecture

- **Stack:** Rails 8.1 "omakase" defaults — no JavaScript, Propshaft for assets, SQLite for everything.
- **Databases:** dev/test use a single SQLite DB in `storage/`. Production uses four SQLite DBs (primary, cache, queue, cable) — Solid Cache, Solid Queue, and Solid Cable each have their own schema file (`db/*_schema.rb`) and migration path (`db/*_migrate`).
- **Background jobs:** Solid Queue (`bin/jobs`), no Redis.
- **Deployment:** Kamal (`config/deploy.yml`, `.kamal/`) with the root `Dockerfile`, served via Thruster in front of Puma.

# Word Counter

A small Rails 8 app: paste a block of text and get its word, character and sentence counts, updated in place without a page reload.

## Requirements

- Ruby 3.4.4 (see `.ruby-version`)
- SQLite 3

## Run it

```bash
bin/setup     # installs gems, prepares the database, starts the server
```

Or, once set up:

```bash
bin/dev
```

Then open http://localhost:3000.

## How it works

| Piece | Role |
|---|---|
| `app/models/text_stats.rb` | Plain Ruby class (no database table) that does the counting |
| `app/controllers/pages_controller.rb` | `home` shows the form; `count` handles the submission |
| `app/views/pages/` | The form, a `_results` partial, and a Turbo Stream that swaps in new results |

Counting rules:

- **Words:** runs of letters or digits in any language, keeping inner apostrophes and hyphens (`don't`, `well-known`, `café`)
- **Characters:** every character, including spaces and punctuation
- **Sentences:** text split on `.`, `!` and `?`. Repeated marks (`?!`, `...`) count as one ending, and a final sentence without punctuation still counts. Abbreviations like "Mr." are counted as sentence breaks.

## Tests and checks

```bash
bin/rails test                                 # all tests
bin/rails test test/models/text_stats_test.rb  # one file
bin/rubocop                                    # style
bin/ci                                         # everything CI runs
```

## Ruby practice assignment

`assignment/` is a separate, plain-Ruby exercise (not loaded by the app) that rebuilds a word counter step by step to practise classes, enumerables, hashes, and blocks.

```bash
cd assignment
ruby check.rb   # grades your progress one checkpoint at a time
```

See `assignment/CHECKPOINTS.md` for the prompts at each step.

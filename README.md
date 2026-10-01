# Word Counter

A small, beginner-friendly Rails 8 app: paste a block of text and get its word, character and sentence counts.

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

1. `config/routes.rb` sends `GET /` (open the page) and `POST /` (submit the form) to the same place: `PagesController#home`.
2. `app/controllers/pages_controller.rb` builds a `TextStats` from the submitted text (`params[:text]`, empty on first visit).
3. `app/views/pages/home.html.erb` shows the form with your text still in it, plus the three counts.
4. `app/models/text_stats.rb` is a plain Ruby class (no database) that does the counting:
   - **Words:** the text split on spaces. `"Hello there, friend!"` is 3 words.
   - **Characters:** every character, including spaces and punctuation.
   - **Sentences:** the text cut at `.`, `!` or `?`, counting the pieces that aren't blank. `...` and `?!` count as one ending, and "Mr." counts as a sentence break.

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

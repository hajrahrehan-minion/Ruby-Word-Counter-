# Word Counter: checkpoints

Every checkpoint follows the same loop. Don't skip ahead.

1. **Predict:** write your guess *before* running anything. A wrong guess you wrote down teaches you more than a right one you didn't.
2. **Build:** fill in the methods in `word_counter.rb` until `ruby check.rb` shows all ✓.
3. **Explain-back:** answer in your own words, as if teaching a friend. No copying docs.
4. **Break-it:** sabotage your working code as described, run `ruby check.rb`, record exactly what happened, then undo it.
5. **Go over it with Claude.** Paste your answers. Only start the next checkpoint once that conversation is done.

To try the predictions, open irb with your class loaded:

```bash
irb -r ./word_counter.rb
```

---

## Checkpoint 1: Objects & classes

### Predict
| Code | Your guess | Actual |
|---|---|---|
| `WordCounter.new` (no argument) | | |
| `WordCounter.new("Hi").instance_variables` *(after you build it)* | | |

### Explain-back
1. What's the difference between `@text` and `text` in your class?
2. Why does the spec want `nil` turned into `""`? What would break later if it stayed `nil`?

### Break-it
- Delete your `attr_reader` line. Which error do you get, and from which line of `check.rb`?
- Rename `initialize` to `setup`. What error now? Why does Ruby care about that exact name?

---

## Checkpoint 2: Methods & strings

### Predict
| Code | Your guess | Actual |
|---|---|---|
| `"Hello, hello world!".split` | | |
| `"Hello, hello world!".downcase.scan(/[a-z']+/)` | | |
| `"Café au lait".downcase.scan(/[a-z']+/)` | | |

### Explain-back
1. Why `scan` instead of `split` here?
2. Your `word_count` should call `words` rather than redo the work. Why does that matter?
3. Your Rails app's `TextStats` counts words with plain `text.split`. Using your predictions, what does your `words` method get right that `split` doesn't? And what does the `"Café"` prediction show that *your* version gets wrong?

### Break-it
- Remove `.downcase`. Which checks fail? Which *later* method (checkpoints 4 and 6) would quietly give wrong answers instead of crashing?
- In Ruby, the last expression in a method is returned automatically. Add a line `puts "done"` at the end of `words`. What does `words` return now, and what happens to `word_count`?

---

## Checkpoint 3: Arrays & enumerables

### Predict
| Code | Your guess | Actual |
|---|---|---|
| `[1, 2, 3].map { \|n\| n * 2 }` | | |
| `[1, 2, 3].each { \|n\| n * 2 }` | | |
| `%w[a bb ccc].select { \|w\| w.length > 1 }` | | |
| `%w[a bb ccc].max_by(&:length)` | | |
| `[].max_by(&:length)` | | |

### Explain-back
1. `map` and `each` both loop. What does each one *return*, and when would you use each?
2. Rewrite `words_longer_than` in your head using `reject` instead of `select`. What changes?

### Break-it
- Swap `map` for `each` in `word_lengths`. What does it return now, and why didn't Ruby raise an error?

---

## Checkpoint 4: Hashes & symbols

### Predict
| Code | Your guess | Actual |
|---|---|---|
| `h = Hash.new(0); h["x"] += 1; h` | | |
| `h = {}; h["x"] += 1; h` | | |
| `{ words: 3 }[:words]` | | |
| `{ words: 3 }["words"]` | | |
| `:words.object_id == :words.object_id` | | |
| `"words".object_id == "words".object_id` | | |

### Explain-back
1. What does the `0` in `Hash.new(0)` do?
2. What does `each_with_object` hand to your block, and what does it return at the end?
3. Symbols vs strings: why does Rails use `params[:text]` and `{ words: 11 }` style keys so much?

### Break-it
- Change `Hash.new(0)` to `{}`. Read the error. Explain *exactly* which value is `nil` and why.
- Change `stats` to use string keys (`"words" =>`). Why does the check fail even though the numbers are right?

---

## Checkpoint 5: reduce

### Predict
| Code | Your guess | Actual |
|---|---|---|
| `[1, 2, 3].reduce(0) { \|sum, n\| sum + n }` | | |
| `[].reduce(:+)` | | |
| `[].reduce(0, :+)` | | |
| `7 / 2` | | |
| `7 / 2.0` | | |
| `0 / 0` | | |
| `0.0 / 0` | | |

### Explain-back
1. Walk through `[1, 2, 3].reduce(0) { |sum, n| sum + n }` step by step. What are `sum` and `n` on each pass?
2. Why does the starting value (`0`) matter? Use your predictions above.

### Break-it
- Remove whatever handles the "no words" case. Run the check on `""`. What do you get, and does it depend on whether you used `.to_f`?

---

## Checkpoint 6: Blocks & procs

### Predict
| Code | Your guess | Actual |
|---|---|---|
| `def greet = yield("Ann")` then `greet { \|name\| "Hi #{name}" }` | | |
| `proc { \|a, b\| [a, b] }.call(1)` | | |
| `->(a, b) { [a, b] }.call(1)` | | |
| `%w[a b].map(&:upcase)` | | |

### Explain-back
1. What's the difference between a block, a proc and a lambda? (The two predictions in the middle are your evidence.)
2. In `c.count_words_where(&->(word) { word.length == 2 })`, what is the `&` doing?
3. How does your `sort_by` handle the alphabetical tie-break?

### Break-it
- Remove your `block_given?` check and call `c.count_words_where` with no block. What's the error called?
- Sort only by count (drop the alphabetical part). Run `c.top_words(3)` a few times. Is the third word guaranteed?

---

## Stretch: stop words

Make `c.top_words(2, skip_stop_words: true)` skip boring words like "the" and "it", using `WordCounter::STOP_WORDS`.

### Design question (answer *before* coding)
There are three places you could filter out stop words: `words`, `frequencies` or `top_words`. Which one should it be, and why? (Hint: the last stretch check verifies `c.word_count` is still 11.)

### Predict
| Code | Your guess | Actual |
|---|---|---|
| `%w[the cat the].reject { \|w\| %w[the].include?(w) }` | | |
| `c.top_words(2, skip_stop_words: true)` *before* you change anything | | |

### Explain-back
1. Why does `skip_stop_words: false` as a default keep the old `c.top_words(2)` working?
2. `"THE"` is a stop word too, but `STOP_WORDS` only lists lowercase words. Why does it still get skipped?

### Break-it
- Put the filtering inside `words` instead. Which checks fail, and why is that a real bug and not just a picky test?

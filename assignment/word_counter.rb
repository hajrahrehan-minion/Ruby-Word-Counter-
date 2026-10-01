# Word Counter assignment
#
# Build this class one checkpoint at a time. After each one:
#   1. ruby check.rb               -> get every line to ✓
#   2. Open CHECKPOINTS.md         -> Predict, Explain-back, Break-it
#   3. Go over your answers with Claude, THEN start the next checkpoint.
#
# To experiment: irb -r ./word_counter.rb
#
# Replace each `raise NotImplementedError` with your code.

class WordCounter
  # Used in the stretch. Ignore it until then.
  STOP_WORDS = %w[
    a an and are as at be but by did do for from has have i in is it
    of on or so that the this to was were will with
  ].freeze

  # ---------------------------------------------------------------
  # CHECKPOINT 1: Objects & classes
  # ---------------------------------------------------------------

  # Store the text so `counter.text` returns it.
  # WordCounter.new(nil).text should return "" (empty string), not nil.
  def initialize(text)
    raise NotImplementedError
  end

  # You'll also need ONE line (not a method) so `counter.text` works.
  # Hint: you saw it in TextStats.

  # ---------------------------------------------------------------
  # CHECKPOINT 2: Methods & strings
  # ---------------------------------------------------------------

  # Lowercase words with punctuation stripped. Apostrophes stay.
  # "Hello, hello world!" => ["hello", "hello", "world"]
  # Hint: look up String#downcase and String#scan. /[a-z']+/ matches a word.
  def words
    raise NotImplementedError
  end

  # Hint: don't repeat yourself. Use a method you already wrote.
  def word_count
    raise NotImplementedError
  end

  # ---------------------------------------------------------------
  # CHECKPOINT 3: Arrays & enumerables (map, select, max_by)
  # ---------------------------------------------------------------

  # Length of each word. "I love Ruby" => [1, 4, 4]
  # Use: map
  def word_lengths
    raise NotImplementedError
  end

  # Words with MORE than `length` letters.
  # Use: select
  def words_longer_than(length)
    raise NotImplementedError
  end

  # The longest word, or nil when there are no words.
  # Use: max_by
  def longest_word
    raise NotImplementedError
  end

  # ---------------------------------------------------------------
  # CHECKPOINT 4: Hashes & symbols (each_with_object)
  # ---------------------------------------------------------------

  # How many times each word appears. "b a b" => { "b" => 2, "a" => 1 }
  # Use: each_with_object (not `tally`, which does it for you;
  # try tally afterwards and compare).
  def frequencies
    raise NotImplementedError
  end

  # A summary hash with SYMBOL keys:
  # { words: 11, unique_words: 8, characters: 45 }
  # characters counts everything, including spaces and punctuation.
  def stats
    raise NotImplementedError
  end

  # ---------------------------------------------------------------
  # CHECKPOINT 5: reduce
  # ---------------------------------------------------------------

  # Average letters per word, rounded to 2 decimal places.
  # "hi there you" => 3.33. No words => 0.0
  # Use: reduce to add up the lengths.
  def average_word_length
    raise NotImplementedError
  end

  # ---------------------------------------------------------------
  # CHECKPOINT 6: Blocks & procs
  # ---------------------------------------------------------------

  # The n most common words as [word, count] pairs, most common first.
  # Ties go in alphabetical order.
  # c.top_words(2) => [["the", 3], ["cat", 2]]
  # Hint: sort_by can sort by an array, e.g. [first_rule, second_rule].
  def top_words(n)
    raise NotImplementedError
  end

  # How many words the caller's block says yes to.
  # c.count_words_where { |word| word.start_with?("c") } => 2
  # With NO block, return the total word count.
  # Hint: yield, block_given?
  def count_words_where
    raise NotImplementedError
  end

  # ---------------------------------------------------------------
  # STRETCH: stop words (see CHECKPOINTS.md before you start)
  # ---------------------------------------------------------------
  # No new method. Change top_words so this works:
  #   c.top_words(2, skip_stop_words: true) => [["cat", 2], ["dog", 1]]
  # and c.top_words(2) still behaves exactly as before.
end

# Grades your WordCounter one checkpoint at a time.
# Run: ruby check.rb
# You don't need to edit this file.

require_relative "word_counter"

SAMPLE = "The cat sat. The cat ran! Did the dog see it?"

def c = WordCounter.new(SAMPLE)

CHECKPOINTS = [
  [ "1: Objects & classes", [
    [ 'WordCounter.new("Hi there").text', "Hi there" ],
    [ "WordCounter.new(nil).text", "" ]
  ] ],
  [ "2: Methods & strings", [
    [ 'WordCounter.new("Hello, hello world!").words', %w[hello hello world] ],
    [ %q(WordCounter.new("Don't stop").words), %w[don't stop] ],
    [ 'WordCounter.new("").words', [] ],
    [ "c.word_count", 11 ]
  ] ],
  [ "3: Arrays & enumerables (map, select, max_by)", [
    [ 'WordCounter.new("I love Ruby").word_lengths', [ 1, 4, 4 ] ],
    [ 'WordCounter.new("I love Ruby programming").words_longer_than(3)', %w[love ruby programming] ],
    [ 'WordCounter.new("I love Ruby programming").longest_word', "programming" ],
    [ 'WordCounter.new("").longest_word', nil ]
  ] ],
  [ "4: Hashes & symbols (each_with_object)", [
    [ 'WordCounter.new("b a b").frequencies', { "b" => 2, "a" => 1 } ],
    [ "c.frequencies", { "the" => 3, "cat" => 2, "sat" => 1, "ran" => 1, "did" => 1, "dog" => 1, "see" => 1, "it" => 1 } ],
    [ "c.stats", { words: 11, unique_words: 8, characters: 45 } ]
  ] ],
  [ "5: reduce", [
    [ 'WordCounter.new("I love Ruby").average_word_length', 3.0 ],
    [ 'WordCounter.new("hi there you").average_word_length', 3.33 ],
    [ 'WordCounter.new("").average_word_length', 0.0 ]
  ] ],
  [ "6: Blocks & procs", [
    [ "c.top_words(2)", [ [ "the", 3 ], [ "cat", 2 ] ] ],
    [ "c.top_words(3)", [ [ "the", 3 ], [ "cat", 2 ], [ "did", 1 ] ] ],
    [ 'c.count_words_where { |word| word.start_with?("c") }', 2 ],
    [ 'c.count_words_where(&->(word) { word.length == 2 })', 1 ],
    [ "c.count_words_where", 11 ]
  ] ],
  [ "Stretch: stop words", [
    [ "c.top_words(2, skip_stop_words: true)", [ [ "cat", 2 ], [ "dog", 1 ] ] ],
    [ 'WordCounter.new("THE The the end").top_words(5, skip_stop_words: true)', [ [ "end", 1 ] ] ],
    [ "c.top_words(2)", [ [ "the", 3 ], [ "cat", 2 ] ] ],
    [ "c.word_count", 11 ]
  ] ]
]

def run_check(code, expected)
  actual = eval(code)
  if actual == expected
    puts "  ✓ #{code} => #{actual.inspect}"
    :pass
  else
    puts "  ✗ #{code}"
    puts "      expected: #{expected.inspect}"
    puts "      got:      #{actual.inspect}"
    :fail
  end
rescue NotImplementedError
  puts "  · #{code}  (not written yet)"
  :todo
rescue StandardError => e
  puts "  ✗ #{code}"
  puts "      #{e.class}: #{e.message}"
  :fail
end

puts "c = WordCounter.new(#{SAMPLE.inspect})"

CHECKPOINTS.each_with_index do |(title, checks), index|
  puts "\nCheckpoint #{title}"
  results = checks.map { |code, expected| run_check(code, expected) }
  next if results.all?(:pass)

  if results.all?(:todo) && index.positive?
    puts "\nCheckpoint #{CHECKPOINTS[index - 1].first} passes."
    puts "Before writing the next one: do its Predict, Explain-back and Break-it"
    puts "in CHECKPOINTS.md, and go over your answers with Claude."
  else
    puts "\nStopped at checkpoint #{title}. Get every line to ✓ before moving on."
  end
  exit 1
end

puts "\nEvery checkpoint passes, stretch included."

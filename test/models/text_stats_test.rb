require "test_helper"

class TextStatsTest < ActiveSupport::TestCase
  test "counts words including contractions, hyphens, and accented letters" do
    assert_equal 4, TextStats.new("Don't stop, well-known café!").word_count
  end

  test "counts characters including whitespace" do
    assert_equal 11, TextStats.new("hello world").character_count
  end

  test "counts sentences ending in . ! or ?" do
    assert_equal 3, TextStats.new("Hi there. How are you? Great!").sentence_count
  end

  test "counts trailing text without punctuation as a sentence" do
    assert_equal 2, TextStats.new("First one. Second one").sentence_count
  end

  test "treats repeated punctuation as one sentence end" do
    assert_equal 2, TextStats.new("Wait... what?!").sentence_count
  end

  test "handles blank input" do
    stats = TextStats.new(nil)
    assert_equal [ 0, 0, 0 ], [ stats.word_count, stats.character_count, stats.sentence_count ]
  end
end

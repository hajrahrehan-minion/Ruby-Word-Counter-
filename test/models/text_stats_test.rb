require "test_helper"

class TextStatsTest < ActiveSupport::TestCase
  test "counts words separated by spaces" do
    assert_equal 3, TextStats.new("Hello there, friend!").word_count
  end

  test "counts characters including spaces and punctuation" do
    assert_equal 12, TextStats.new("hello world!").character_count
  end

  test "counts sentences ending in . ! or ?" do
    assert_equal 3, TextStats.new("Hi there. How are you? Great!").sentence_count
  end

  test "counts a last sentence without punctuation" do
    assert_equal 2, TextStats.new("First one. Second one").sentence_count
  end

  test "treats ... or ?! as one sentence ending" do
    assert_equal 2, TextStats.new("Wait... what?!").sentence_count
  end

  test "does not end a sentence after Mr. or other abbreviations" do
    assert_equal 1, TextStats.new("Mr. Bean").sentence_count
    assert_equal 1, TextStats.new("Mr.Bean").sentence_count
    assert_equal 1, TextStats.new("Mr. Bean met Dr. Smith in the U.S. today.").sentence_count
    assert_equal 2, TextStats.new("Mr. Bean laughed. Mrs. Wicket did not!").sentence_count
  end

  test "does not end a sentence inside a number" do
    assert_equal 1, TextStats.new("Pi is 3.14 today").sentence_count
  end

  test "ignores punctuation with no words" do
    assert_equal 0, TextStats.new("... ?!").sentence_count
  end

  test "handles empty text" do
    stats = TextStats.new(nil)
    assert_equal 0, stats.word_count
    assert_equal 0, stats.character_count
    assert_equal 0, stats.sentence_count
  end
end

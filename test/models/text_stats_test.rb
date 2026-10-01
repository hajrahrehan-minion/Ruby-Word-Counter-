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

  test "handles empty text" do
    stats = TextStats.new(nil)
    assert_equal 0, stats.word_count
    assert_equal 0, stats.character_count
    assert_equal 0, stats.sentence_count
  end
end

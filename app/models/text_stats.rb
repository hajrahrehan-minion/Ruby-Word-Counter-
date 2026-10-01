# Counts the words, characters and sentences in a piece of text.
class TextStats
  attr_reader :text

  def initialize(text)
    @text = text.to_s # turns nil into "" so the counts below never crash
  end

  # Splits the text on spaces: "Hello there, friend!" => ["Hello", "there,", "friend!"]
  def word_count
    text.split.size
  end

  # Every character counts, including spaces and punctuation.
  def character_count
    text.length
  end

  # Cuts the text at . ! or ? and counts the pieces that aren't blank.
  def sentence_count
    text.split(/[.!?]+/).count { |piece| piece.strip != "" }
  end
end

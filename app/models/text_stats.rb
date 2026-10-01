# Counts the words, characters and sentences in a piece of text.
class TextStats
  # Words that end in a period but don't end a sentence: "Mr. Bean" is one sentence.
  ABBREVIATIONS = %w[mr. mrs. ms. dr. prof. sr. jr. st. mt. vs. etc. no.]

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

  # A sentence ends at a word that finishes with . ! or ? (like "Wait..." or "what?!"),
  # unless that word is an abbreviation such as "Mr." Text left over after the last
  # ending still counts as one sentence. "Mr.Bean" and "3.14" have no space after the
  # dot, so they never end a sentence.
  def sentence_count
    words = text.split.select { |word| word.match?(/[[:alnum:]]/) }
    endings = words.count { |word| sentence_end?(word) }
    endings += 1 if words.any? && !sentence_end?(words.last)
    endings
  end

  private

  def sentence_end?(word)
    word.match?(/[.!?]["')\]]*\z/) && !abbreviation?(word)
  end

  def abbreviation?(word)
    ABBREVIATIONS.include?(word.downcase) || word.match?(/\A([[:alpha:]]\.){2,}\z/) # "U.S." or "e.g."
  end
end

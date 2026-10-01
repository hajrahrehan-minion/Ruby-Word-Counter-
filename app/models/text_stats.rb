class TextStats
  # Letters/digits, allowing inner apostrophes or hyphens ("don't", "well-known")
  WORD = /[\p{L}\p{N}]+(?:['’-][\p{L}\p{N}]+)*/
  SENTENCE_END = /[.!?]+/

  attr_reader :text

  def initialize(text)
    @text = text.to_s
  end

  def word_count
    text.scan(WORD).size
  end

  def character_count
    text.length
  end

  def sentence_count
    text.split(SENTENCE_END).count { |sentence| sentence.match?(WORD) }
  end
end

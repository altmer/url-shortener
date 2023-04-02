module Hasher
  HASHED_URL_LENGTH = 7

  def self.create_hashed_url
    character_set.sample(HASHED_URL_LENGTH).join
  end

  def self.character_set
    @character_set ||= [('a'..'z'), ('A'..'Z'), (0..9)].map(&:to_a).flatten
  end
end

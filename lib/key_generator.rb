class KeyGenerator
  CHARSETS = {
    :alphanum => ('a'..'z').to_a + (0..9).to_a,
    :alphanumcase => ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a }

  def self.generate(length=6, charset=:alphanum)
    charset = CHARSETS[charset] if charset.instance_of? Symbol
    (0...length).map{ charset[rand(charset.size)] }.join
  end
end
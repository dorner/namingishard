module ProfanityChecker

  # @param word [String]
  # @return [Boolean] true if there is an issue
  def self.check(word)
    url = 'https://www.purgomalum.com/service/containsprofanity'
    result = HTTParty.get(url, query: { text: word })
    result.body != 'false'
  end
end

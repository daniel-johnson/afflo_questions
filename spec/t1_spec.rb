require_relative "../questions/t1"

RSpec.describe WordService do
  describe "#is_palindrome?" do
    it 'returns false for non-palindrome strings' do
      expect(WordService.is_palindrome?("race a car")).to(eq(false))
    end

    it 'returns true for a valid palindrome, not counting non-alphanumeric characters' do
      expect(
        WordService.is_palindrome?("A man, a plan, a canal: Panama")
      ).to(eq(true))
    end

    it 'returns true for the simplest valid palindrome' do
      expect(
        WordService.is_palindrome?(" ")
      ).to(eq(true))
    end
  end
end

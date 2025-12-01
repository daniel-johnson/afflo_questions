# Task 1 - Valid Palindromes
#   A phrase is a palindrome if, after converting all uppercase letters into lowercase letters and
#   removing all non-alphanumeric characters, it reads the same forward and backward.
#   Alphanumeric characters include letters and numbers.

#   Given a string s, create a Ruby function that returns true if it is a palindrome, or false otherwise.

#   Example 1:
#   Input: s = "A man, a plan, a canal: Panama"
#   Output: true
#   Explanation: "amanaplanacanalpanama" is a palindrome.

#   Example 2:
#   Input: s = "race a car"
#   Output: false
#   Explanation: "raceacar" is not a palindrome.

#   Example 3:
#   Input: s = " "
#   Output: true
#   Explanation: s is an empty string "" after removing non-alphanumeric characters.
#   Since an empty string reads the same forward and backward, it is a palindrome.

class WordService
  def self.is_palindrome?(string)
    cleaned_string = string.downcase.gsub(/[^a-z0-9]/, '')
    cleaned_string == cleaned_string.reverse
  end
end

# puts "Is 'race a car' a palindrome? : #{ is_palindrome?('race a car') }"
# puts "Is 'A man, a plan, a canal: Panama' a palindrome? : #{ is_palindrome?('A man, a plan, a canal: Panama') }"
# puts "Is ' ' a palindrome? : #{ is_palindrome?(' ') }"

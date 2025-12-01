# Task 3 - Recursive Flattening

# Write a recursive Ruby method flatten_and_filter that takes:
# - a nested array of integers (arrays can contain integers or other arrays, arbitrarily nested)
# - a block that acts as a filter

# The method should:
# - flatten the nested array into a single array of integers
# - only include integers for which the block returns true
# - be implemented recursively without using Array#flatten

def flatten_and_filter(array, &block)
  result = []

  array.each do |element|
    if element.is_a?(Array)
      result = result + flatten_and_filter(element, &block)
    elsif block.call(element)
      result << element
    end
  end
  
  result
end

# Example 1: only keep even numbers
  nested_array_1 = [1, [2, 3], [4, [5, 6]]]
  puts "Example 1 expected output: [2, 4, 6]"
  p flatten_and_filter(nested_array_1) { |n| n.even? }

# Example 2: keep numbers greater than 3
  nested_array_2 = [1, [2, 3], [4, [5, 6]]]
  puts "Example 2 expected output: [4, 5, 6]"
  p flatten_and_filter(nested_array_2) { |n| n > 3 }

# Example 3: keep all numbers (block always true)
  nested_array_3 = [1, [2, 3], [4, [5, 6]]]
  puts "Example 2 expected output: [1, 2, 3, 4, 5, 6]"
  p flatten_and_filter(nested_array_3) { true }


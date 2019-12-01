lines = File.readlines('input.txt')
sum = lines
  .map { |l| Integer(l) / 3 - 2 }
  .sum

puts sum

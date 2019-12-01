def fuel(m)
  mf = Integer(m) / 3 - 2
  if mf > 0
    m + fuel(mf)
  else
    m
  end
end

lines = File.readlines('input.txt')
sum = lines
  .map(&:to_i)
  .map { |l| fuel(l) - l }
  .sum

puts sum

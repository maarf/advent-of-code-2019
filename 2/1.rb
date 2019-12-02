positions = File.read('input.txt').split(',').map(&:to_i)
cursor = 0

# Fix the input
positions[1] = 12
positions[2] = 2

loop do
  case positions[cursor]
  when 1
    source1 = positions[positions[cursor + 1]]
    source2 = positions[positions[cursor + 2]]
    destination_cursor = positions[cursor + 3]
    positions[destination_cursor] = source1 + source2
  when 2
    source1 = positions[positions[cursor + 1]]
    source2 = positions[positions[cursor + 2]]
    destination_cursor = positions[cursor + 3]
    positions[destination_cursor] = source1 * source2
  when 99
    puts positions[0]
    return
  else
    raise StandardError, 'Unknown command'
  end
  cursor += 4
end

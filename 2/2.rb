list = File.read('input.txt').split(',').map(&:to_i)

# Fix the input
list[1] = 12
list[2] = 2

def computer(memory)
  inst_pointer = 0
  loop do
    case memory[inst_pointer]
    when 1
      param1 = memory[memory[inst_pointer + 1]]
      param2 = memory[memory[inst_pointer + 2]]
      dest_pointer = memory[inst_pointer + 3]
      memory[dest_pointer] = param1 + param2
      inst_pointer += 4
    when 2
      param1 = memory[memory[inst_pointer + 1]]
      param2 = memory[memory[inst_pointer + 2]]
      dest_pointer = memory[inst_pointer + 3]
      memory[dest_pointer] = param1 * param2
      inst_pointer += 4
    when 99
      return memory[0]
    else
      raise StandardError, 'Unknown command'
    end
  end
end

expect = 19690720

(0..99).each do |noun|
  (0..99).each do |verb|
    memory = list.dup
    memory[1] = noun
    memory[2] = verb
    result = computer(memory)
    if result == expect
      puts "#{result}: #{noun} #{verb} #{100 * noun + verb}"
      return
    end
  end
end

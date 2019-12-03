require 'set'
require 'byebug'

lines = File.readlines('input.txt')
wires = lines.map { |l| l.split(',') }

def untangle(path)
  points = Set.new
  end_point = [0, 0]
  path.each do |loc|
    direction = loc[0]
    distance = Integer(loc[1..-1])
    case direction
    when 'R'
      (1..distance).each { |d| points.add([end_point[0] + d, end_point[1]]) }
      end_point = [end_point[0] + distance, end_point[1]]
    when 'L'
      (1..distance).each { |d| points.add([end_point[0] - d, end_point[1]]) }
      end_point = [end_point[0] - distance, end_point[1]]
    when 'U'
      (1..distance).each { |d| points.add([end_point[0], end_point[1] + d]) }
      end_point = [end_point[0], end_point[1] + distance]
    when 'D'
      (1..distance).each { |d| points.add([end_point[0], end_point[1] - d]) }
      end_point = [end_point[0], end_point[1] - distance]
    end
  end
  return points
end

def measure(path, x, y)
  total_distance = 0
  end_point = [0, 0]
  path.each do |loc|
    direction = loc[0]
    distance = Integer(loc[1..-1])
    cx = end_point[0]
    cy = end_point[1]
    case direction
    when 'R'
      if ((cx + 1)..(cx + distance)).include?(x) && cy == y
        return total_distance + x - cx
      end
      end_point = [end_point[0] + distance, end_point[1]]
    when 'L'
      if ((cx - distance)..(cx - 1)).include?(x) && cy == y
        return total_distance + x - cx
      end
      end_point = [end_point[0] - distance, end_point[1]]
    when 'U'
      if cx == x && ((cy + 1)..(cy + distance)).include?(y)
        return total_distance + y - cy
      end
      end_point = [end_point[0], end_point[1] + distance]
    when 'D'
      if cx == x && ((cy - distance)..(cy - 1)).include?(y)
        return total_distance + y - cy
      end
      end_point = [end_point[0], end_point[1] - distance]
    end
    total_distance += distance
  end
  nil
end

intersections = untangle(wires[0]) & untangle(wires[1])

min_steps = intersections
  .map { |i| measure(wires[0], i[0], i[1]) + measure(wires[1], i[0], i[1]) }
  .min

puts min_steps

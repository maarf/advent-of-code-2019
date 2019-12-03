require 'set'

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

intersections = untangle(wires[0]) & untangle(wires[1])

min_distance = intersections
  .map { |i| i[0].abs + i[1].abs }
  .min

puts min_distance

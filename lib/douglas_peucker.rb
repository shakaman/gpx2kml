# encoding: utf-8
$:.unshift(File.dirname(__FILE__))

class DouglasPeucker

  def initialize(points_list, epsilon=10e-8)
    @points_list  = points_list
    @epsilon      = epsilon

    @points = simplify_line(@points_list)
  end

  def simplify_line(points)
    dmax = 0
    index = 0

    (1..(points.length - 1)).each do |i|
      d = perpendicular_distance(points[i], points.first, points.last)
      if d > dmax
        index = i
        dmax = d
      end
    end

    if dmax >= @epsilon
      results_1 = simplify_line(points[0..index])
      results_2 = simplify_line(points[index..-1])

      results_1[0..-2] + results_2
    else
      [points.first, points.last]
    end
  end

  def perpendicular_distance(point, line_start, line_end)
    line  = {
      start: {
        x: line_start[:lat].to_f,
        y: line_start[:lon].to_f
      },
      end: {
        x: line_end[:lat].to_f,
        y: line_end[:lon].to_f
      }
    }
    point = { x: point[:lat].to_f, y: point[:lon].to_f }

    numerator = ((line[:end][:x] - line[:start][:x])*(line[:start][:y] - point[:y]) - (line[:start][:x] - point[:x])*(line[:end][:y] - line[:start][:y]))
    denominator = (line[:end][:x] - line[:start][:x])**2 + (line[:end][:y] - line[:start][:y])**2

    numerator.abs/denominator**0.5
  end
end

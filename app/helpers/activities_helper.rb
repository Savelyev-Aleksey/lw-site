module ActivitiesHelper
  def light? (color)
     r = color[1..2].to_i(16)
     g = color[3..4].to_i(16)
     b = color[5..6].to_i(16)
     0.213 * r + 0.815 * g + 0.072 * b > 127
  end
end

require_relative './tabletop'
require_relative './placement_rules'

class ToyRobot
  def initialize
    placement_rules = PlacementRules.new
    @tabletop = Tabletop.new(placement_rules)
  end

  def place(x:, y:, orientation:)
    tabletop.place(x: x, y: y, orientation: orientation)
  end

  def left
    case tabletop.current_orientation
    when 'N'
      tabletop.set_orientation('W')
    when 'S'
      tabletop.set_orientation('E')
    when 'W'
      tabletop.set_orientation('S')
    when 'E'
      tabletop.set_orientation('N')
    end
  end

  def right
    case tabletop.current_orientation
    when 'N'
      tabletop.set_orientation('E')
    when 'S'
      tabletop.set_orientation('W')
    when 'W'
      tabletop.set_orientation('N')
    when 'E'
      tabletop.set_orientation('S')
    end
  end

  def move
    case tabletop.current_orientation
    when 'N'
      tabletop.set_y_position(tabletop.current_y_position + 1)
    when 'S'
      tabletop.set_y_position(tabletop.current_y_position - 1)
    when 'W'
      tabletop.set_x_position(tabletop.current_x_position - 1)
    when 'E'
      tabletop.set_x_position(tabletop.current_x_position + 1)
    end
  rescue Tabletop::InvalidPlacement
  end

  def report
    tabletop.current_robot_position
  end

  private
  attr_reader :tabletop
end

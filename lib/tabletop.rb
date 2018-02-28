class Tabletop
  class UnplacedRobotError < StandardError; end
  class InvalidPlacement < StandardError; end

  X = 0
  Y = 1
  ORIENTATION = 2

  def initialize(placement_rules)
    @placement_rules = placement_rules
    @current_position = [-1, -1, 'N']
  end

  def current_orientation
    current_position[ORIENTATION]
  end

  def current_x_position
    current_position[X]
  end

  def current_y_position
    current_position[Y]
  end

  def set_orientation(orientation)
    place(x: current_position[X],
          y: current_position[Y],
          orientation: orientation)
  end

  def set_x_position(x)
    place(x: x,
          y: current_position[Y],
          orientation: current_position[ORIENTATION])
  end

  def set_y_position(y)
    place(x: current_position[X],
          y: y,
          orientation: current_position[ORIENTATION])
  end

  def current_robot_position
    raise UnplacedRobotError if unplaced_robot?
    # puts "REPORT: #{current_position}"
    current_position
  end

  def place(x:, y:, orientation:)
    raise InvalidPlacement unless placement_rules.valid_placement?(x: x, y: y)
    @current_position = [x, y, orientation]
  end

  private
  attr_reader :current_position, :placement_rules

  def unplaced_robot?
    current_position[X] == -1
  end
end

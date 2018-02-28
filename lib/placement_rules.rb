class PlacementRules
  def valid_placement?(x:, y:)
    return false if x < 0 || x > 4
    return false if y < 0 || y > 4
    true
  end
end

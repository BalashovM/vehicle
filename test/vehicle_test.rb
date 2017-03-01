require_relative '../lib/vehicle_class'
require_relative 'test'

class VehicleTest < Test

  def test_vehicle_constructor
    vehicle1 = Vehicle.new(3, 3, 3, "Тест транспорта 1")

    vehicle('Тест транспорта 1', 3, 3, 3, 0, vehicle1.MOVING_STATES(1), vehicle1.HEALT_STATES(0))
  end
end
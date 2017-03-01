#require_relative 'vehicle_class'
require './lib/vehicle_class'

class Car < Vehicle
  def initialize
    super(4, 4, 4, 'Автомобиль')
  	@damage_resist = 4
  end
end
#require_relative 'vehicle_class'
require './lib/vehicle_class'

class Minibus < Vehicle
  def initialize
    super(5, 6, 3, 'Микроавтобус')
	  #@boost = 3 # of 1..5
	  #@speed_max = 3 # of 1..5
	  @damage_resist = 9 # of 1..10
  end
end
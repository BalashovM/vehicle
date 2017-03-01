#require_relative 'infrastructure_class'
require './lib/infrastructure_class'

class Traffic_circle < Infrastructure
  def initialize
    super(3,'Круговое движение')
    @movement_direction = ['первый съезд','второй съезд','третий съезд','развернуться по круговому движению']
    #@speed_after = @speed_before/2
  end
  
  #@movement_direction = ['первый съезд','второй съезд','третий съезд','развернуться по круговому движению']
  #puts "#{@name}, @movement_direction - #{@movement_direction} "
end
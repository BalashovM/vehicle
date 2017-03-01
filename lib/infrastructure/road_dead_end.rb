#require_relative 'infrastructure_class'
require './lib/infrastructure_class'

class Road_dead_end < Infrastructure
  def initialize
    super(1,'Тупик')
    @movement_direction =  [nil, nil, nil, 'развернуться']
    #@speed_after = 1
  end
  
  #@movement_direction =  [nil, nil, nil, 'развернуться']
  #puts "#{@name}, @movement_direction - #{@movement_direction} "
end
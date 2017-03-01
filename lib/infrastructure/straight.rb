#require_relative 'infrastructure_class'
require './lib/infrastructure_class'

class Straight < Infrastructure
  def initialize
    super(1,'Прямая')
    @movement_direction =  [nil, 'ехать прямо', nil, nil]
    #@speed_after = @speed_before
  end
  
  #@movement_direction =  [nil, 'ехать прямо', nil, nil]
  #puts "#{@name}, @movement_direction - #{@movement_direction} "
end
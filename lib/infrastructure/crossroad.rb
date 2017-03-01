#require_relative 'infrastructure_class'
require './lib/infrastructure_class'

class Crossroad < Infrastructure
  def initialize
    super(2,'Перекресток')
    #@speed_after = @speed_before/3
    @movement_direction = ['направо', 'ехать прямо', 'налево','развернуться']
    #puts 'initialize Перекресток'
  end

  #@movement_direction = ['направо', 'ехать прямо', 'налево','развернуться']
  #puts "#{@name}, @movement_direction - #{@movement_direction} "
end
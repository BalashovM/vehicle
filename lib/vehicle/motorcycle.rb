#require_relative 'vehicle_class'
require './lib/vehicle_class'

class Motorcycle < Vehicle
  def initialize
    super(0, 2, 5, 'Мотоцикл')
    #@boost = 5 # of 1..5
    #@speed_max = 5 # of 1..5
    @damage_resist = 2 # of 1..10    
  end
  
  def boom_vech!
    @doors  = 0

    wheels_before = @wheels 
    wheels_boom =  rand(@wheels+1)
=begin
    puts "@wheels = #{@wheels}, wheels_boom = #{wheels_boom}"
    puts "(@damage_resist / 10) #{(@damage_resist / 10.0)}"
    puts "(1 - (@damage_resist / 10)) #{(1 - (@damage_resist / 10.0))}"
    puts "(wheels_boom * (1 - (@damage_resist / 10))) #{(wheels_boom * (1 - (@damage_resist / 10.0)))}"
    puts "(wheels_boom * (1 - (@damage_resist / 10))).round #{(wheels_boom * (1 - (@damage_resist / 10.0))).round}"
=end
    @wheels -= (wheels_boom * (1 - (@damage_resist / 10.0))).round
    healt_state!(0,wheels_before)

  end
end
# Класс Транспорт

class Vehicle

  MOVING_STATES = {'moving' => 'Движится', 'stoped' => 'Стоит'}
  HEALT_STATES  = {'good' => 'Целый'  , 'damaged' => 'Поврежденный' ,  'broken' => 'Сломанный'} 

  attr_accessor :speed
  attr_accessor :last_moving_direction # 0..3 ['направо', 'ехать прямо', 'налево','развернуться']

  def initialize(doors_count = 4, wheels_count = 4, speed = 4, kind = 'Транспорт')
    @doors = doors_count
    @wheels = wheels_count 
    @speed = speed # of 1..5
    @name = kind
    
    @health_state = HEALT_STATES['good']
    @action_state = MOVING_STATES['stoped']
    
    #@boost = 3 # of 1..5
    #@damage_resist = 5 # of 1..10
    
    @normal_doors_count = doors_count
    @normal_wheels_count = wheels_count
  end

  def self.descendants
    ObjectSpace.each_object(Class).select {|klass| klass < self}.map{|klass| klass.new}
  end

  def name
    "#{@name}"
  end
  
  def health_state
    @health_state
  end 

  def doors
    @doors
  end
  
  def wheels
    @wheels
  end

  def speed
    @speed
  end

  def go_move!
    if self.class == Vehicle
      puts "Техника должна быть конкретной - выберите транспорт!"
      return
    else
       @action_state = MOVING_STATES['moving']
    end
  end

  def stop!
    @action_state = MOVING_STATES['stoped']
  end

  #def boost 
  #  @boost
  #end

  def damage_resist
    @damage_resist
  end

  def boom_vech!
    doors_before = @doors
    wheels_before = @wheels 

    doors_boom = rand(@doors - 1)
    wheels_boom =  rand(@wheels - 1)

    @doors -= (doors_boom * (1 - (@damage_resist / 10))).round
    @wheels -= (wheels_boom * (1 - (@damage_resist / 10))).round

    healt_state!(doors_before,wheels_before)
  end

  def healt_state!(doors_before,wheels_before)
    if ((doors_before > @doors) || (wheels_before > @wheels))
      if (@wheels <= 0)
        @health_state = HEALT_STATES['broken']
        @action_state = MOVING_STATES['stoped']
      else 
        @health_state = HEALT_STATES['damaged']
      end 
    end
  end

  def inspect
    "#{name}:[количество колёс=#{@wheels}, количество дверей=#{@doors}, состояние движения=#{@action_state}, состояние целостности=#{@health_state}, стойкость к повреждениям ={@damage_resits}]"
  end
end 

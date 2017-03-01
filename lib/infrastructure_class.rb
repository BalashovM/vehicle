#Класс Инфраструктура

class Infrastructure
  
  #USE_STATE = {'use' => 'использовать', 'not_use'=> 'не использовать'}
  TRAFFIC_LIGHTS = [['broken','сломан'],['red','красный'],['elloy','желтый'],['green','зеленый']]
  TRAFFIC_LIGHT_STATE = {0 => 'broken', 1 => 'red', 2 => 'elloy', 3 => 'green'}
  @movement_direction = Array[]

  def initialize(danger_level = 0, kind = 'Инфраструктура')
    @name = kind
    @traffic_light_use =  false 
    @traffic_light = nil
    
    #@movement_direction =  ['направо', 'ехать прямо', 'налево','развернуться'] #для всех видов аналог задаётся
    #@danger_level = danger_level # 0..3
    #@speed_before = 0
    #@speed_after = 0
    #@use_state = USE_STATE['not_use'];
  end
  
  def name
    "#{@name}"
  end
  
  def self.descendants
    ObjectSpace.each_object(Class).select {|klass| klass < self}.map{|klass| klass.new}
  end

  def traffic_lights_init 
    @traffic_light_use = rand(2) == 1
    if @traffic_light_use
      @traffic_light = TRAFFIC_LIGHT_STATE[rand(4)]
    end
  end 
  
  def traffic_light_use?
    @traffic_light_use
  end

  def get_traffic_light
    if @traffic_light_use
      TRAFFIC_LIGHTS.find_all{|elem| elem[0] == @traffic_light}[0]
    end
  end

  def movement_direction
    @movement_direction
  end

  def get_movement_direction_text_choice
    i = 0
    text_choice = nil
    while i< @movement_direction.size
      if @movement_direction[i] != nil
        if text_choice == nil
          text_choice = "#{i+1} - #{@movement_direction[i]} "
        else 
          text_choice = text_choice + ' | ' + "#{i+1} - #{@movement_direction[i]} "
        end 
      end
      i += 1
    end
    return text_choice
  end
end 
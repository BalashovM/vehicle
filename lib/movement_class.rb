require_relative ('infrastructure_class')

class Movement 

  START_X = 0
  START_Y = 0
   
  DISTANCE_TIME = 3 #We accept motion intervals of 3 minutes
  #description, probability, crash
  EVENTS = [[nil, 0.75, false],
            ['Вам улыбнулась девушка в соседней машине', 0.5, false],
            ['Вас подрезал другой водитель', 0.4, false],
            ['Вас пропустил вперед тонированный джип', 0.3, false],
            ['Вы попали в аварию', 0.2, true]] 
 
  attr_accessor :time_left

  def initialize(vehicle, infrastructure_array, time_limit)
    set_destination_point()
    @arrival = false
    @vehicle = vehicle
    @infrastructure_array = infrastructure_array
    @time_left = time_limit
  end

  def arrival?
    @arrival
  end

  def set_destination_point
    @dest_x = rand(20..50)
    @dest_y = rand(20..50)
  end
  
  def move_next #For the probability of each event, we add a random value and return maximum results
    @time_left = @time_left - DISTANCE_TIME 
    event_with_probability = EVENTS.map{|i| i[1] + (rand(100)/100.0)}
    
    event_next = EVENTS[event_with_probability.index(event_with_probability.max)]

    #Crash?
    if event_next[2]
      @vehicle.boom_vech!
      if @vehicle.health_state == Vehicle::HEALT_STATES['broken']
          puts "Вам не повезло, ваш транспорт попал в аварию и не может продолжать движение."
          puts "У него осталось #{@vehicle.doors} дверей, и #{@vehicle.wheels} колес." 
          puts " Игра окончена, попробуйте ещё раз."
      else 
          puts "Вам не повезло, ваш транспорт попал в аварию, но он может продолжать движение."
          puts "У него осталось #{@vehicle.doors} дверей, и #{@vehicle.wheels} колес." 
      end
    else 
      puts "#{(event_next[0] == nil ? 'Ничего не происходит' : event_next[0])}, едем дальше."
    end 
  end

  def get_point_next(moving_direction, vehicle_speed)
    #Calc with boost
    #offset = vehicle.speed * DISTANCE_TIME + ((vehicle.boost * (DISTANCE_TIME ** 2))/2) 
    
    offset = vehicle_speed * DISTANCE_TIME

    case moving_direction 
      when  0
        @current_x = @current_x ? @current_x          : START_X 
        @current_y = @current_y ? @current_y - offset : START_Y - offset
      when  1
        @current_x = @current_x ? @current_x + offset : START_X + offset
        @current_y = @current_y ? @current_y          : START_Y 
      when  2
        @current_x = @current_x ? @current_x          : START_X 
        @current_y = @current_y ? @current_y + offset : START_Y + offset
      when  3
        @current_x = @current_x ? @current_x - offset : START_X - offset
        @current_y = @current_y ? @current_y          : START_Y 
    end

    @arrival = (get_distance() < offset) #We accept that if the distance to tehe destination is less then the last movement? we arrived at the destination
    
  end

  def get_distance #The calculation of the Cartesian distance between points
    Math.sqrt(((@dest_x - (@current_x ? @current_x : 0))**2) + ((@dest_y - (@current_y ? @current_y : 0))**2))
  end

  def infrastructure_next
    infrastructure_current = @infrastructure_array[rand(@infrastructure_array.length)]
    infrastructure_current.traffic_lights_init()
    
    traffic_light_speed = @vehicle.speed
    
    if infrastructure_current.traffic_light_use?
      case Infrastructure::TRAFFIC_LIGHT_STATE.select{|key, value| value == infrastructure_current.get_traffic_light()[0]}.keys[0]
        when 0
          message_text = "Перед вами #{infrastructure_current.name}, на нём светофор который не работает, выберите направление движения:" 
        when 1,2
          message_text = "Перед вами #{infrastructure_current.name}, на нём светофор на котором горит #{infrastructure_current.get_traffic_light()[1]} свет, вы вынуждены остановиться, выберите направление движения после разрешающего сигнала светофора:"
          traffic_light_speed = 0
        when 3
          message_text = "Перед вами #{infrastructure_current.name}, на нём светофор на котором горит #{infrastructure_current.get_traffic_light()[1]} свет, выберите направление движения:"
        else 
          message_text = "Перед вами #{infrastructure_current.name}, выберите направление движения:"
      end 
    else 
      message_text = "Перед вами #{infrastructure_current.name}, выберите направление движения:"
    end 

    elements_count = infrastructure_current.movement_direction.length
    movement_direction_text = infrastructure_current.get_movement_direction_text_choice

    return [infrastructure_current.movement_direction, message_text, movement_direction_text, traffic_light_speed]
  end
end
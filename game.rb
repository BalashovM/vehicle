require './lib/vehicle/car'
require './lib/vehicle/motorcycle'
require './lib/vehicle/minibus'

require './lib/infrastructure/straight'
require './lib/infrastructure/crossroad'
require './lib/infrastructure/traffic_circle'
require './lib/infrastructure/road_dead_end'

require_relative ('lib/movement_class')
require_relative ('lib/user_setting_class')

def user_choice(elements_count, message)

	variant = Array.new(elements_count){ |index| index + 1 } 	

	while (true) do 
		puts message
		print 'Ваш выбор: ' 
		user_choice = gets.chomp.to_i

		if variant.include?(user_choice) 
			return user_choice
		else 
			puts 'Введены не верные данные попробуйте еще раз'
		end
	end 
end

puts "\nПриветствуем Вас, в игре Пункт назначения!"
puts 'Вам предстоит добраться до пункта назначения, где он вы не знаете, есть только расстояние от текущего местоположения, до конечной точки.'
puts 'В вашем расспоряжении, на выбор, есть несколько транспортных средств.'
puts 'Выбирая направление движения вы будете, либо приближаться к конечной точке, либо удаляться от неё.'
puts 'От выбранного уровня сложности зависит время, за которое вам предстоит проийти весь путь.'
puts 'По пути у вас может случится авария, и ваше транспортное средство может получить повреждения, но если повреждения не критичны, вы cможете продолжить свой путь!'

if user_choice(2,'1 - Начать, 2 - Выход') == 1

	user_settings = User_settings.new
	user_settings.difficulty_level_choice()
	user_settings.vehicle_choice()
	user_settings.infrastructure_init()

	user_movement = Movement.new(user_settings.vehicle_by_user, user_settings.infrastructure_by_user, user_settings.time_limit_by_user)

	puts "\nВы выбрали #{user_settings.vehicle_by_user.name}, время на поездку #{user_settings.time_limit_by_user} минут, расстояние до точки назначения #{user_movement.get_distance.round} км \nПоехали!"

	user_settings.vehicle_by_user.go_move!

	until (user_movement.time_left < 0 || @arrival)

		user_movement.move_next()
		ifra_answer = user_movement.infrastructure_next()
		puts ifra_answer[1]
		
		while  (true) do
			user_choice_direction = user_choice(ifra_answer[0].length,ifra_answer[2])
			
			if ifra_answer[0][user_choice_direction-1] == nil
				puts "Введены не верные данные попробуйте еще раз"
				puts "Выберите направление движения:"
			else
				break
			end
		end

		puts "Вы выбрали направление - #{ifra_answer[0][user_choice_direction-1]}"

		user_movement.get_point_next(user_choice_direction-1, ifra_answer[3])
		
		if user_movement.arrival?
			if user_settings.vehicle_by_user.health_state != Vehicle::HEALT_STATES['broken']
				puts 'ПОЗДРАВЛЯЕМ ВЫ ВЫИГРАЛИ !!!'
				puts "Вы добрались до точки назначения за #{user_settings.time_limit_by_user - user_movement.time_left} минут"
			end
			break
		else 
			if user_movement.time_left>0
				if ifra_answer[3] = 0 
					message_text = "Вы потеряли время на светофоре, придётся нагонять.\n"
				else 
					message_text = nil
				end 
				puts "\n" + message_text + "Осталось проехать #{user_movement.get_distance.round} км за время #{user_movement.time_left} минуты"
			end
		end
	end

	if !user_movement.arrival?
		puts "К сожалению время вышло, осталось доехать #{user_movement.get_distance.round} км , попробуйте ещё раз. \nМы верим - в следующий раз Вам повезет :-)"
	end
end
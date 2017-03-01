require_relative ('vehicle_class')
require_relative ('infrastructure_class')

class User_settings

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

  def vehicle_choice()
    @vehicle_array = Vehicle.descendants
    vehicle_list = ""
    @vehicle_array.each_with_index{|vehicle, number| vehicle_list = vehicle_list + "\n\t" + (number + 1).to_s + " - " + vehicle.name + ", cтойкость к повреждениям - " + vehicle.damage_resist.to_s + ", cкорость - " + vehicle.speed.to_s}
    manifest_text = "Выберите транспорт:" + vehicle_list
    @user_vehicle = @vehicle_array[user_choice(@vehicle_array.size, manifest_text)-1]
  end

  def infrastructure_init
    @infrastructure_array = Infrastructure.descendants
  end

  def infrastructure_by_user
    @infrastructure_array
  end

    def vehicle_by_user
    @user_vehicle
  end

  def difficulty_level_choice()
    @time_limit = case user_choice(3,"Выберите уровень сложности: \n\t1 - лёгкий \n\t2 - средний \n\t3 - сложный")
                    when 1 then 60
                    when 2 then 50
                    when 3 then 40
                  end
  end

  def time_limit_by_user
    @time_limit
  end
end

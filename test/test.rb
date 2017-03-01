require 'test/unit'

class Test < Test::Unit::TestCase

  def vehicle(name, doors, wheels, speed, damage_resits, motion_state, healt_state)
    assert_equal(name, vehicle.name)
    assert_equal(doors, vehicle.doors)
    assert_equal(wheels, vehicle.wheels)
    assert_equal(speed, vehicle.speed)
    assert_equal(damage_resits, vehicle.damage_resits)
    assert_equal(motion_state, vehicle.motion_state)
    assert_equal(healt_state, vehicle.healt_state)
  end

end

test
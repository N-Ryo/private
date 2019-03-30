class Car

  UP_SPEED = 10
  DOWN_SPEED = 20

  attr_accessor :number, :color
  attr_reader :speed
  @@count = 0

  def initialize(color)
    puts "Carクラスのインスタンスを生成しました。"
    @color = color
    @@count += 1
    @speed = 0
    @number = @@count
  end

  def self.count
    @@count
  end

  def speed_up
    @speed += UP_SPEED
  end

  def speed_down
    @speed = @speed >= DOWN_SPEED ? @speed - DOWN_SPEED : 0
  end
end

class EvCar < Car
attr_reader :battery

  def initialize(color)
    super
    @battery = 100
  end

end



car1 = Car.new("red")

car1.speed_up
puts car1.speed


ev_car1 = EvCar.new("blue")
puts ev_car1.battery

ev_car1.speed_up
puts ev_car1.speed
puts Car.count
puts EvCar.count
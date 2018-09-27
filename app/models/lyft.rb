class Ride
  @@all = []

  attr_accessor :distance, :passenger, :driver

  def initialize(distance, passenger, driver)
    @distance = distance
    @passenger = passenger
    @driver = driver
    @@all << self
  end

  def self.average_distance
    (self.all.sum {|ride| ride.distance}.to_f / self.all.size).round(2)
  end

  def self.all
    @@all
  end


end


class Passenger
  @@all = []

  attr_accessor :name

  def initialize(name)
    @name = name
    @@all << self
  end

  def create_ride(distance, driver)
    Ride.new(distance, self, driver)
  end

  def self.all
    @@all
  end

  def rides
    Ride.all.select {|ride| ride.passenger == self }
  end

  def drivers
    rides.map { |ride| ride.driver }.uniq
  end

  def total_distance
    rides.sum {|ride| ride.distance}
  end

  def self.premium_members
    Passenger.all.select { |passenger| passenger.total_distance > 100 }
  end

end


class Driver
  @@all = []

  attr_accessor :name

  def initialize(name)
    @name = name
    @@all << self
  end

  def self.all
    @@all
  end

  def rides
    Ride.all.select {|ride| ride.driver == self }
  end

  def passengers
    rides.map { |ride| ride.passenger }.uniq
  end

  def total_distance
    rides.sum {|ride| ride.distance}
  end

  def self.mileage_cap(distance)
    Driver.all.select { |driver| driver.total_distance > distance }
  end

  #def create_ride(distance, passenger)
  #  Ride.new(distance, passenger, self)
  #end

end

akmal = Passenger.new("Akmal")
ayne = Passenger.new("Ayne")
ezryn = Passenger.new("Ezryn")

haziq = Driver.new("Haziq")
diana = Driver.new("Diana")

ride1 = akmal.create_ride(12, haziq)
ride2 = akmal.create_ride(15, diana)
ride3 = akmal.create_ride(67, haziq)
ride4 = akmal.create_ride(8, haziq)

ride5 = ayne.create_ride(23, diana)
ride6 = ayne.create_ride(9, haziq)

ride7 = ezryn.create_ride(102, haziq)

binding.pry
p "eof"

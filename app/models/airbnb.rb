class Trip
  @@all = []

  attr_accessor :date, :guest, :listing

  def initialize(date, listing, guest)
    @date = date
    @listing = listing
    @guest = guest
    @@all << self
  end

  def self.all
    @@all
  end
end

class Listing
  @@all = []

  attr_accessor :name, :trip, :city, :guest

  def initialize(name, city)
    @name = name
    @city = city
    @@all << self
  end

  def self.all
    @@all
  end

  # Host of a listing should be able to create trips
  def create_trip(date, guest)
    Trip.new(date, self, guest)
  end

  # All trips made at a listing
  def trips
    Trip.all.select { |trip| trip.listing == self }
  end

  def trip_count
    trips.count
  end

  def guests
    trips.map { |trip| trip.guest }
  end
end

class Guest
  @@all = []

  attr_accessor :name, :trip, :listing

  def initialize(name)
    @name = name
    @@all << self
  end

  def self.all
    @@all
  end

  # Guest should be able to create trips
  def create_trip(date, listing)
    Trip.new(date, listing, self)
  end

  # Get all trips made by an instance of Guest
  def trips
    Trip.all.select { |trip| trip.guest == self }
  end

  def trip_count
    trips.count
  end

  def listings
    trips.map { |trip| trip.listing }
  end

end

bream = Listing.new('Bream Close', 'London')
paddington = Listing.new('Paddington', 'London')
hale = Listing.new('Hale Village', 'Liverpool')
devonshire = Listing.new('Devonshire Terrace', 'London')
lapwing = Listing.new('Lapwing Heights', 'London')

akmal = Guest.new('Akmal')
ayne = Guest.new('Ayne')
haziq = Guest.new('Haziq')
diana = Guest.new('Diana')

akmal_bream = akmal.create_trip('May 1', bream)
akmal_lapwing = akmal.create_trip('May 10', lapwing)
ayne_devonshire = ayne.create_trip('May 25', devonshire)
haziq.create_trip('Sept 1', lapwing)
diana.create_trip('Sept 6', hale)
diana.create_trip('Sept 10', paddington)

binding.pry
p 'eof'

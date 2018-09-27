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

  # Using defined trips, count the number or results in the Array
  def trip_count
    trips.count
  end

  # Using defined trips, map it to only include listing instance
  def guests
    trips.map { |trip| trip.guest }
  end

  def self.find_all_by_city(city)
    Listing.all.select { |listing| listing.city == city }
  end

  def self.most_popular
    # Create a new has, listing as key, trip count as value | then uses max_by to select max count(array), return instance of top listing
    counter_hash = Listing.all.map { |listing| [listing, listing.trip_count] }.to_h
    counter_hash.max_by { |listing, count| count }.first
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

  # Using defined trips, count the number or results in the Array
  def trip_count
    trips.count
  end

  # Using defined trips, map it to only include listing instance
  def listings
    trips.map { |trip| trip.listing }
  end

  def self.find_all_by_name(name)
    Guest.all.select { |guest| guest.name == name }
  end

  def self.pro_traveller
    Guest.all.select { |guest| guest.trip_count > 1 }
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
ezryn = Guest.new('Ezryn')

akmal_bream = akmal.create_trip('May 1', bream)
akmal_lapwing = akmal.create_trip('May 10', lapwing)
ayne_devonshire = ayne.create_trip('May 25', devonshire)
haziq.create_trip('Sept 1', lapwing)
diana.create_trip('Sept 6', hale)
diana.create_trip('Sept 10', paddington)

# binding.pry
# p 'eof'

require "test_helper"

describe Passenger do
  let (:new_passenger) {
  Passenger.new(name: "Kari", phone_num: "111-111-1211")}
  it "can be instantiated" do
    # Assert
    expect(new_passenger.valid?).must_equal true
  end
  
  it "will have the required fields" do
    # Arrange
    new_passenger.save
    passenger = Passenger.first
    [:name, :phone_num].each do |field|
      
      # Assert
      expect(passenger).must_respond_to field
    end
  end
  
  describe "relationships" do
    it "can have many trips" do
      # Arrange
      new_passenger.save
      new_driver = Driver.create(name: "Waldo", vin: "ALWSS52P9NEYLVDE9")
      trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234)
      trip_2 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 3, cost: 6334)

      # Assert
      expect(new_passenger.trips.count).must_equal 2
      new_passenger.trips.each do |trip|
        expect(trip).must_be_instance_of Trip
      end
    end
  end
  
  describe "validations" do
    it "must have a name" do
      # Arrange
      new_passenger.name = nil
      
      # Assert
      expect(new_passenger.valid?).must_equal false
      expect(new_passenger.errors.messages).must_include :name
      expect(new_passenger.errors.messages[:name]).must_equal ["can't be blank"]
    end
    
    it "must have a phone number" do
      # Arrange
      new_passenger.phone_num = nil
      
      # Assert
      expect(new_passenger.valid?).must_equal false
      expect(new_passenger.errors.messages).must_include :phone_num
      expect(new_passenger.errors.messages[:phone_num]).must_equal ["can't be blank"]
    end
  end
    
    describe 'total_spent' do
      it 'accurately calcuates and returns total spent' do
        current_driver = Driver.create(name: "Jane Doe", vin: "12345678")
        passenger = Passenger.create(name: "John Doe", phone_num: "7654321")
        first_trip = Trip.create(cost: 10, date: Date.today, driver_id: current_driver.id, passenger_id: passenger.id, rating: 5)
        second_trip = Trip.create(cost: 10, date: Date.today, driver_id: current_driver.id, passenger_id: passenger.id, rating: 3)

        expect(passenger.total_spent).must_equal 20
      end
      it 'returns 0 if passenger hasnt taken any trips' do
        passenger = Passenger.create(name: "John Doe", phone_num: "7654321")
        expect(passenger.total_spent).must_equal 0
      end
    end

  end

  # We instead put these methods in the controller and is being tested in controller tests
  # Tests for methods you create should go here
  describe "custom methods" do
    describe "request a ride" do
      # Your code here
    end
    
    describe "complete trip" do
      # Your code here
    end
    # You may have additional methods to test here

  
end

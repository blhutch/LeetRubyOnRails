class Airport < ActiveRecord::Base
	has_many :flights through :user_flights
end

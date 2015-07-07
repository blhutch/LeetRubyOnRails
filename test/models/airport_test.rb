require 'test_helper'

class AirportTest < ActiveSupport::TestCase

  test "airport_short_name_3_letters" do
    
    short_name.length == 3
    assert true

  end

  test "airport_short_name_unique" do

    short_name.unique
    assert true

  end
 
end

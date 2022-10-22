require 'test_helper'

class TemperatureReadingsControllerTest < ActionDispatch::IntegrationTest
  test "should get csv" do
    get temperature_readings_csv_url
    assert_response :success
  end

end

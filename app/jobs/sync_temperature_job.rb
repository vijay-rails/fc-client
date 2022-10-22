class SyncTemperatureJob < ApplicationJob
  queue_as :default

  def perform
    begin
      if SpaceShip.get_comms_up == true
        sensor_statuses = SensorStatus.where(status: SensorStatus::STATUS_TYPES[:pending]).order(:created_at)
        #http://rubybunny.info/articles/error_handling.html
        sensor_statuses.each do |sensor_status|
          sensor = sensor_status.sensor
          puts "Job called for status id #{sensor_status.id} and sensor #{sensor_status.sensor.id}"
          Publisher.publish('temperatures', 
            {
              temperature: ApplicationController.helpers.fahrenheit_to_celcius(sensor.temperature), 
              timestamp: sensor.created_at.utc.iso8601(3)
            }
          )
          sensor_status.update(status: SensorStatus::STATUS_TYPES[:completed])
        end
      end
    rescue Bunny::TCPConnectionFailed => error
      #comms is down
      if SpaceShip.get_comms_up == true
        SpaceShip.set_comms_up = false
        #let the SpaceShip Know something's wrong in connectivity even though - 
        # - connection seems to be up
      end
    rescue StandardError => error
        #Send an email out or report in slack
    ensure
      puts "Comms up is #{SpaceShip.get_comms_up}"
      SyncTemperatureJob.set(wait: 1.second).perform_later()
    end
  end
end

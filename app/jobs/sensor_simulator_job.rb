class SensorSimulatorJob < ApplicationJob
  queue_as :default

  def perform
    begin
      random_number = rand(1..10)
      random_number.times.each do
        Sensor.create(temperature: (rand(10..20) * 10))
      end
    rescue StandardError => error
        #Send an email out or report in slack
    ensure
      SensorSimulatorJob.set(wait: random_number.second).perform_later()
    end
  end
end

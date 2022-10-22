require 'bunny'
class Consumer
  class << self
    def read_from_queue
      conn = Bunny.new
      conn.start
      conn.queue_exists?("earth.readings")
      ch = conn.create_channel
      queue_temperatures = ch.queue("earth.readings")
      
      queue_temperatures.subscribe(:manual_ack => true) do |delivery_info, properties, payload|
        puts "Received #{payload}, message properties are #{properties.inspect}"
        received_hash = JSON.parse(payload)
        
        begin
          TemperatureReading.create!(
            temperature: received_hash['temperature'].to_f.round(2),
            measured_at: received_hash['timestamp'].to_datetime.utc.iso8601(3)
          )
        rescue ActiveRecord::RecordNotUnique => e
          puts "Inside RecordNotUnique Error"
          ch.ack(delivery_info.delivery_tag)
        rescue StandardError => error
          #Send an email out or report in slack
          puts "Inside standard Error"
        end
        ch.ack(delivery_info.delivery_tag)
      end
    end
   
  end
end
module TemperatureReadingsHelper

  def find_records_and_write_to_file
    file = Tempfile.create("temp.csv")

    CSV.open(file, "wb") do |csv|
      csv << ["Current Temperature", "Change in Temperature", "Timestamp"]
      previous_reading = TemperatureReading.order(:id).first

      TemperatureReading.find_in_batches do |temperature_readings|
        temperature_readings.each do |temperature_reading|
          temperature_difference = temperature_reading.temperature - previous_reading.temperature
          csv << [temperature_reading.temperature, temperature_difference, temperature_reading.measured_at.utc.iso8601(3)]
          previous_reading = temperature_reading
        end
      end
    end
    file
  end
end

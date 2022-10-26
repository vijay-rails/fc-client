require 'CSV'
class TemperatureReadingsController < ApplicationController
  include TemperatureReadingsHelper
  def csv
    file = find_records_and_write_to_file

    send_file(file, :filename => "temperatures.csv", :type => "text/csv")
  end

  def toggle_comms
    SpaceShip.set_comms_up(!SpaceShip.get_comms_up)
    render json: {comms: SpaceShip.get_comms_up}, status: 200
  end

  def get_comms
    render json: {comms: SpaceShip.get_comms_up}, status: 200
  end

  def start
    begin
      SensorSimulatorJob.perform_now
      SyncTemperatureJob.perform_now
      Consumer.read_from_queue
      render json: {status: true}, status: 200
    rescue StandardError => error
      render json: {status: false}, status: 200
    end
  end
end

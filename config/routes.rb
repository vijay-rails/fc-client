Rails.application.routes.draw do
  get 'temperature_readings/csv'
  get 'temperature_readings/toggle_comms'
  get 'temperature_readings/get_comms'
  get 'temperature_readings/manage_comms'
  get 'temperature_readings/start'
end
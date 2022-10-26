# README

Run the migrations

Install RabbitMQ, Check if it runs on "http://localhost:15672/", credentials: guest/guest

Run "SensorSimulatorJob.perform_now" once and run "rake rabbitmq:setup". This will create exchange and bind the queue.

Go to "http://localhost:3000/temperature_readings/manage_comms"

Click "Start" to start the sensors and readings

Click "Toggle" to change comms status

Click "CSV" to view the csv file in developer console

Use the end-point "http://localhost:3000/temperature_readings/csv" to download CSV
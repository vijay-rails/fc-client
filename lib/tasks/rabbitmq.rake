# app/lib/tasks/rabbitmq.rake
namespace :rabbitmq do
  desc "Connect consumer to producer"
  task :setup do
    require "bunny"
    conn = Bunny.new.tap(&:start)
    ch = conn.create_channel
    queue_temperatures = ch.queue("earth.readings")
    # bind queue to exchange
    queue_temperatures.bind("ship.temperatures")
    conn.close
  end
end
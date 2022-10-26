require 'bunny'
class Publisher
  class << self
    def publish(exchange, message = {})
      x = channel.fanout("ship.#{exchange}")
      x.publish(message.to_json)
    end
    def channel
      @channel ||= connection.create_channel
    end
    def connection
      @connection ||= Bunny.new.tap(&:start)
    end
  end
end
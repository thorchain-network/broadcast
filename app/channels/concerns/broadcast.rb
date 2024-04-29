module Broadcast
  def initialize_broadcast
    @buffer = {}
  end

  private

  def broadcast
    Rails.configuration.networks.each do |network|
      message = payload(network)

      next if message == @buffer[network]

      ActionCable.server.broadcast(network, message)
      @buffer[network] = message
    end
  end

  def payload(network)
    Memory.redis.get(key(network))
  end

  def key(network)
    "#{Rails.application.config_for(:cable)[:channel_prefix]}_#{network}_#{suffix}"
  end
end

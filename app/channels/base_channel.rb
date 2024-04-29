class BaseChannel < ApplicationCable::Channel
  include Broadcast
  include Suffix

  periodically :broadcast, every: Rails.configuration.frequency.seconds

  def initialize(*args)
    super
    initialize_broadcast
  end

  def subscribed
    network = params[:network]
    return reject_connection(network) unless Rails.configuration.networks.include?(network)

    stream_from network
    transmit(payload(network))
  end

  private

  def reject_connection(network)
    Rails.logger.info "Connection for unsupported network rejected: #{network}"
    stop_all_streams
    connection.close
  end
end

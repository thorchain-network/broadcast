module Memory
  class << self
    def redis
      @redis ||= Redis.new(url: Rails.application.config_for(:cable)[:url])
    end
  end
end

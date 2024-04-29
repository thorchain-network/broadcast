module Log
  class Formatter < ActiveSupport::Logger::Formatter
    RESET = "\e[0m".freeze
    TRANSFORM = {
      'DEBUG' => ['DBG', "\e[34m"],   # Blue
      'INFO' => ['INF', "\e[32m"],    # Green
      'WARN' => ['WRN', "\e[33m"],    # Yellow
      'ERROR' => ['ERR', "\e[31m"],   # Red
      'FATAL' => ['FTL', "\e[35m"],   # Magenta
      'UNKNOWN' => ['UNK', "\e[37m"]  # White
    }.freeze

    def initialize
      super
      @log_color = ENV.fetch('LOG_COLOR', '') == 'enabled'
    end

    def call(severity, time, _progname, msg)
      paint = TRANSFORM[severity][1] || "\e[37m"
      rigidity = TRANSFORM[severity][0] || 'UNK'

      colors = "#{time.utc.iso8601} #{paint}#{rigidity}#{RESET} #{msg}\n"
      plain = "#{time.utc.iso8601} #{rigidity} #{msg}\n"

      @log_color ? colors : plain
    end
  end
end

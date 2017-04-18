require "logger"

module NmiDirectPost
  class << self
    def logger
      @logger ||= defined?(::Rails.logger) ? Rails.logger : ::Logger.new(STDOUT)
    end

    def logger=(_)
      raise ArgumentError, "NmiDirectPost logger must respond to :info and :debug" unless logger_responds(_)
      @logger = _
    end

    def strip_sensitive_from_string(str)
      str = str.gsub(/cc_number=[0-9]+/i, '|**FILTERED**|')
      str = str.gsub(/cc_exp=[0-9]+/i, '|**FILTERED**|')
      str = str.gsub(/cc_cvv=[0-9]+/i, '|**FILTERED**|')
      str
    rescue => e
      'ERROR stripping out sensitive data'
    end

    private
    def logger_responds(logger)
      logger.respond_to?(:info) && logger.respond_to?(:debug)
    end
  end
end

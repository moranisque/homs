module HBW
  class BaseController < ActionController::Base
    include Controller
    include HttpBasicAuthentication
    before_action :start
    after_action :log

    protected

    def current_user_identifier
      user_identifier || current_user.email
    end

    private

    def start
      @start = Time.now.to_f
    end

    def log
      logger.tagged('DURATION') { logger.info { "#{(Time.now.to_f - @start) * 1000.0}ms, #{request.method} #{request.original_fullpath}" } }
    end
  end
end

require 'logger'

class MyApp
    
    def initialize(opts={})
        trap("SIGINT") do
            puts "Shutting down."
            exit
        end
        set_opts(opts)
    end
    
    def run
        while true
            stats = []
            trace_opts = {}


            ###########################################################################
            # Logging
            ###########################################################################
            @logger.info 'I am running ...'
            sleep 1
        end
    end
    
    private
    
    def set_opts(opts)
        @logger = Logger.new('logs/my_app.log')
        @logger.formatter = proc do |severity, datetime, progname, msg|
          "#{datetime.strftime('%Y-%m-%dT%H:%M:%S.%6N')} #{severity} #{msg}\n"
        end
    end
end
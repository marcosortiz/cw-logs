require 'logger'

class MyApp
    
    MAX_USERS = 25
    MIN_USERS = 5
    
    MAX_JOBS = 50
    MIN_JOBS = 5
    
    MAX_PROCESSING_TIME = 300
    MIN_PROCESSING_TIME = 60
    
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
            @logger.info(get_report)
            change_values
            sleep 1
        end
    end
    
    private
    
    def set_opts(opts)
        @logger = Logger.new('logs/my-app.log')
        @logger.formatter = proc do |severity, datetime, progname, msg|
          "#{datetime.strftime('%Y-%m-%dT%H:%M:%S.%6N')} #{severity} #{msg}\n"
        end
        
        @users     = MIN_USERS
        @jobs      = MIN_JOBS
        @proc_time = MIN_PROCESSING_TIME
        
        @fields = {
            :users => {:change => :inc, :min => MIN_USERS, :max => MAX_USERS, :value => MIN_USERS},
            :jobs => {:change => :inc, :min => MIN_JOBS, :max => MAX_JOBS, :value => MIN_JOBS },
            :proc_time => {:change => :inc, :min => MIN_PROCESSING_TIME, :max => MAX_PROCESSING_TIME, :value => MIN_PROCESSING_TIME },
        }
    end
    
    def change_values
        @fields.each do |k, h|
            change_value(h)
        end
    end
    
    def change_value(h)
        if h[:value] >= h[:max]
            h[:change] = :dec
        elsif h[:value] <= h[:min]
            h[:change] = :inc
        end
        
        if h[:change] == :inc
            h[:value] += 1
        else
            h[:value] -= 1
        end
    end
    
    def get_report
        u = @fields[:users][:value]
        j = @fields[:jobs][:value]
        pt = @fields[:proc_time][:value]
        return "users #{u} jobs #{j} avg_processing_time #{pt}"
    end
    
end
module Mcir::Action::Init
  class Stop < Mcir::Action
    @name = "stop"
    @desc = "stops a instance"

    def setup!
      @config = { force: false, ensure: false, timeout: 10 }
      register_options
    end

    def register_options act = self
      @mcir.opt do
        on("-f", "--force", desc_def("Kill the instance immediately, ignores all following options", false)) { act.config[:force] = true }
        on("-e", "--ensure", desc_def("Kill the instance if the server didn't stop after timeout is reached", false)) { act.config[:ensure] = true }
        on("-t", "--timeout N", Integer, desc_def("Wait N seconds for the instance to stop", 10)) {|t| act.config[:timeout] = t }
      end
    end

    def call instance, args
      @instance = instance

      if !@instance.online?
        @mcir.abort "Can't stop ".red << "#{@instance.name}".magenta << ", not running!".red
      else
        @config[:force] ? force_shutdown : graceful_shutdown
      end
    end

    def force_shutdown
      @mcir.warn "Killing instance ".red << "#{@instance.name}".magenta << "!".red
      @mcir.logger.log_with_print do
        @mcir.warn "Abort within 3 seconds".red
        sleep 1
        3.times{ print ".".red; sleep 1 }
      end
      @mcir.warn "Killing...".red
      @instance.kill!
      wait_for_server_to_shutdown
    end

    def graceful_shutdown
      # send stop to server
      @instance.stop!
      force_shutdown if !wait_for_server_to_shutdown && @config[:ensure]
    end

    def wait_for_server_to_shutdown
      if @config[:timeout] > 0.0
        begin
          time = @mcir.measure do
            @mcir.logger.log_with_print do
              @mcir.log "Wait ".yellow << "#{@config[:timeout]} seconds".magenta << " for instance to stop".yellow
              Timeout::timeout(@config[:timeout]) do
                while @instance.online?
                  print "."
                  sleep 1
                end
              end
            end
          end
          @mcir.log  "Instance ".green <<
                     "#{@instance.name}".magenta <<
                     " successfully stopped (".green <<
                     "#{time[:dist]}".magenta <<
                     ")!".green
          return true
        rescue Timeout::Error => e
          @mcir.warn "Instance ".red <<
                     "#{@instance.name}".magenta <<
                     " failed to stop within ".red <<
                     "#{@config[:timeout]} seconds".purple <<
                     "!".red
          return false
        end
      end
    end
  end
end

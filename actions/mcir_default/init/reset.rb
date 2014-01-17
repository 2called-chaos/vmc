module Mcir::Action::Init
  class Reset < Mcir::Action
    @name = "reset"
    @desc = "hard reset an instance"

    def call instance, args
      @mcir.log "resetting ".yellow << "#{instance.name}".magenta
      @instance = instance
      abort_unless_screen_running!

      instance.in_home do
        # start screen
        @mcir.log instance.reset!
      end
    end

    def abort_unless_screen_running!
      if @instance.online?
        @mcir.abort "Can't reset ".red << "#{@instance.name}".magenta << ", not running!".red
      end
    end
  end
end

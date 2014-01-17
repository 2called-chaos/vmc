module Mcir::Action::Init
  class Unpause < Mcir::Action
    @name = "unpause"
    @desc = "unpauses an instance"

    def call instance, args
      @mcir.log "unpausing ".yellow << "#{instance.name}".magenta
      @instance = instance
      abort_unless_screen_running!

      instance.in_home do
        # start screen
        @mcir.log instance.pause!
      end
    end

    def abort_unless_screen_running!
      unless @instance.online?
        @mcir.abort "Can't unpause ".red << "#{@instance.name}".magenta << ", not running!".red
      end
    end
  end
end

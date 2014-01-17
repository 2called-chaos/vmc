module Mcir::Action::Init
  class Start < Mcir::Action
    @name = "start"
    @desc = "starts an instance"

    def call instance, args
      @instance = instance
      abort_if_screen_running!

      instance.in_home do
        # start screen
        @mcir.log instance.start!
      end
    end

    def abort_if_screen_running!
      if @instance.online?
        @mcir.abort "Can't start ".red << "#{@instance.name}".magenta << ", already running!".red
      end
    end
  end
end

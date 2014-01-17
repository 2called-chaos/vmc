class Mcir::Action::Ip < Mcir::Action
  @name = "ip"
  @desc = "shows vm's IP"

  def call instance, args
    @instance = instance
    abort_unless_screen_running!

    instance.in_home do
      @mcir.log a=instance.get_ip!
      @mcir.log a.out
    end
  end

  def abort_unless_screen_running!
    if @instance.online?
      @mcir.abort "Can't reset ".red << "#{@instance.name}".magenta << ", not running!".red
    end
  end
end

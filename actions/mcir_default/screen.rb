
class Mcir::Action::Screen < Mcir::Action
  @name = "screen"
  @desc = "capture screenshot of guest OS"

  def setup!
    @config = { capture: 1, interval: 1, chmod: true }
    register_options
  end

  def register_options act = self
    @mcir.opt do
      on("-c", "--capture N", Integer, desc_def("number of screens to take", 1)) {|n| act.config[:capture] = n }
      on("-i", "--interval", Float, desc_def("capture interval in seconds", 1)) {|n| act.config[:interval] = n }
      on("-p", "--preserve-permissions", desc_def("do not chmod screen to 0777")) {act.config[:chmod] = false }
    end
  end

  def call instance, args
    @instance = instance
    while true
      f = @instance.capture_screenshot!
      FileUtils.chmod(0777, f) if @config[:chmod]
      print "."
      @config[:capture] -= 1
      @config[:capture] > 0 ? sleep(1) : return puts
    end
  end
end

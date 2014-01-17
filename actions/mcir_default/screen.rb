
class Mcir::Action::Screen < Mcir::Action
  @name = "screen"
  @desc = "capture screenshot of guest OS"

  def setup!
    @config = { capture: 1, interval: 1 }
    register_options
  end

  def register_options act = self
    @mcir.opt do
      on("-c", "--capture N", Integer, desc_def("number of screens to take", 1)) {|n| act.config[:capture] = n }
      on("-i", "--interval", Float, desc_def("capture interval in seconds", 1)) {|n| act.config[:interval] = n }
    end
  end

  def call instance, args
    @instance = instance
    while true
      capture_screenshot!
      @config[:capture] -= 1
      @config[:capture] > 0 ? sleep(1) : return
    end
  end
end

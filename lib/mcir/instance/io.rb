class Mcir::Instance
  # Contains IO operations for instances.
  module IO
    def capture_screenshot!
      dir = "#{home}/screenshots"
      file = "#{dir}/#{Time.now.strftime("%Y%m%d_%H%M%S")}.png"
      FileUtils.mkdir_p(dir)
      capture_screen! file
      file
    end
  end
end

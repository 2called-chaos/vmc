class Mcir::Instance
  # Contains IO operations for instances.
  module IO
    def capture_screenshot!
      dir = "#{home}/screenshots"
      FileUtils.mkdir_p(dir)
      capture_screen! "#{dir}/#{Time.now}.png"
    end
  end
end

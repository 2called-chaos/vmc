class Mcir::Instance
  # Contains getters for file paths.
  module Paths
    # Distincts whether a path is relative or not and prepending the instance's home path if not.
    # @return [String]
    def distinct_relative_path file
      file.to_s.start_with?("/", "~/") ? file : "#{@config["home"]}/#{file}"
    end


  end
end

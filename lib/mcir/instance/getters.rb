class Mcir::Instance
  # Contains getters for instances.
  module Getters
    def engine
      @config["type"]
    end

    def vmx_name
      @config["name"] || @name
    end

    def vmx
      "#{home}/#{vmx_name}.vmx"
    end

    def home
      @config["home"]
    end

    def vm_grid instance
      rlist = vm_list!
      binding.pry
    end

    def online?
      vm_grid(@name)
    end
  end
end

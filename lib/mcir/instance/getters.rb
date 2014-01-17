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
      vm_list!.out.split("\n")[1..-1].each_with_object({}) do |line, grid|
        grid[line] = true
      end[instance]
    end

    def online?
      vm_grid(vmx)
    end
  end
end

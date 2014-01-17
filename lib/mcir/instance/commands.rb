class Mcir::Instance
  # Contains command builders for instances.
  module Commands
    # bangable methods
    [:vmrun, :vm_list].each do |method|
      define_method "#{method}!", ->(*args, &block) do
        self.send(method, *args, &block).execute!
      end
    end

    def vmrun
      Mcir::Command.new("vmrun -T #{engine}")
    end

    def vm_list
      rlist = vmrun + Mcir::Command.new("list")
    end
  end
end

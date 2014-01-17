class Mcir::Instance
  # Contains command builders for instances.
  module Commands
    CMDS = [
      :vmrun, :vm_list, :start, :stop, :kill, :reset, :pause, :unpause, :guest_ip, :capture_screen,
      :file_exists?, :dir_exists?, :rm_file, :rm_dir, :mk_dir, :ls_proc, :kill_proc
    ]
    # bangable methods
    CMDS.each do |method|
      define_method "#{method}!", ->(*args, &block) do
        self.send(method, *args, &block).execute!
      end
    end

    def help_cmd
      @mcir.log "Available commands:"
      CMDS.each_slice(4) do |set|
        @mcir.log set.map{|c| "#{c}(#{method(c).arity})" }.join("\t\t")
      end
    end

    def vmrun
      Mcir::Command.new("vmrun -T #{engine}")
    end

    def vmrung
      Mcir::Command.new(["vmrun -T #{engine}", "-gu #{@config["guser"]}", "-gp #{@config["gpass"]}"])
    end

    def vm_list
      vmrun + Mcir::Command.new("list")
    end

    def start
      vmrun + Mcir::Command.new(["start", vmx, "nogui"])
    end

    def stop
      vmrun + Mcir::Command.new(["stop", vmx, "soft"])
    end

    def kill
      vmrun + Mcir::Command.new(["stop", vmx, "hard"])
    end

    def reset
      vmrun + Mcir::Command.new(["stop", vmx, "hard"])
    end

    def pause
      vmrun + Mcir::Command.new(["pause", vmx])
    end

    def unpause
      vmrun + Mcir::Command.new(["unpause", vmx])
    end

    def guest_ip
      vmrung + Mcir::Command.new(["getGuestIPAddress", vmx])
    end

    def capture_screen file
      vmrung + Mcir::Command.new(["captureScreen", vmx, file])
    end

    def file_exists? file
      vmrung + Mcir::Command.new(["fileExistsInGuest", vmx, file])
    end

    def dir_exists? file
      vmrung + Mcir::Command.new(["directoryExistsInGuest", vmx, file])
    end

    def rm_file file
      vmrung + Mcir::Command.new(["deleteFileInGuest", vmx, file])
    end

    def rm_dir file
      vmrung + Mcir::Command.new(["deleteDirectoryInGuest", vmx, file])
    end

    def mk_dir file
      vmrung + Mcir::Command.new(["createDirectoryInGuest", vmx, file])
    end

    def ls_proc
      vmrung + Mcir::Command.new(["listProcessesInGuest", vmx])
    end

    def kill_proc pid
      vmrung + Mcir::Command.new(["killProcessInGuest", vmx, pid])
    end
  end
end

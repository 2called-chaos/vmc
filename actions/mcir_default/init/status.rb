module Mcir::Action::Init
  class Status < Mcir::Action
    @name = "status"
    @desc = "shows the status of an instance"

    def call instance, args
      if @mcir.logger.enabled?
        @mcir.logger.info @mcir.cgr!(instance.online?,   "VM #{@name}", "ONLINE", "OFFLINE")
      else
        puts stati.to_json
      end
    end
  end
end

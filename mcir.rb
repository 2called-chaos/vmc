MCIR_ROOT = File.expand_path("..", __FILE__)
require "#{MCIR_ROOT}/lib/mcir"

Mcir::Core.dispatch do |mcir|
  # loads all classes in the action folder
  mcir.register_action_classes
end

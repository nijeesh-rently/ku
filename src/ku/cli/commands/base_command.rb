module Ku
  module CLI
    module Commands
      class Base < Dry::CLI::Command
        def initialize(**)
          @command_builder = CommandBuilder.new
          @executor = Executor.new(@command_builder)
          super
        end
      end
    end
  end
end

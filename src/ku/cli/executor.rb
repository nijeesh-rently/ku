module Ku
  module CLI
    class Executor
      def initialize(command_builder)
        @command_builder = command_builder
      end

      def execute!(return_output: false, print_output: true)
        command = @command_builder.command
        puts "Executing: #{command} \n\n"
        if return_output
          result = `#{command}`
          puts result if print_output
          result
        else
          system(command)
        end
      end
    end
  end
end

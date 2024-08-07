module Ku
  module CLI
    class CommandBuilder
      attr_reader :command

      def initialize
        @command = BASE_COMMAND
        append('-n protons') if Context.current_context_is?('dev')
      end

      def append(command)
        @command += " #{command} "
        self
      end
    end
  end
end

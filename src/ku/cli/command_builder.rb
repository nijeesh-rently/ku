# frozen_string_literal: true

module Ku
  module CLI
    # helper class to build kubectl commands
    class CommandBuilder
      BASE_COMMAND = 'kubectl '
      KUBE_CONFIG_PATH = File.expand_path('~/.kube/config')

      attr_reader :command

      def initialize(use_context: true)
        @command = BASE_COMMAND
        append('-n protons') if use_context && Commands::Context.current_context_is?('dev')
      end

      def append(command)
        @command += " #{command} "
        self
      end
    end
  end
end

# frozen_string_literal: true

module Ku
  module CLI
    module Commands
      # Command to get the current context for kubectl
      class Context < Base
        desc 'List all contexts'

        option :stdout, desc: 'print the result', type: :boolean

        def call(stdout: true)
          @command_builder.append('config get-contexts --no-headers')
          @executor.execute!(return_output: stdout)
        end

        def self.current_context
          return @current_context if @current_context

          # we can't use the command builder here because it would create a circular dependency
          result = `kubectl config current-context`
          @current_context = result.strip! || result
        end

        def self.current_context_is?(namespace)
          current_context == namespace
        end
      end
    end
  end
end

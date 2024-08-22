# frozen_string_literal: true

module Ku
  module CLI
    module Commands
      # Command to get env variables from a pod
      class Secret < Base
        desc 'lists all secrets name groups'

        def call(**)
          @command_builder.append('get secrets')
          @command_builder.append('--no-headers -o custom-columns=:metadata.name')
          @executor.execute!
        end
      end
    end
  end
end

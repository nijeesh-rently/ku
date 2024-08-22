# frozen_string_literal: true

module Ku
  module CLI
    module Commands
      # Command to execute command inside a pod
      class Exec < Base
        desc 'execute command inside a pod'

        example [
          'armor                                               # execute bash inside armor pod',
          'armor ls                                            # lists files inside armor pod',
          'armor rails c                                       # runs rails console inside armor pod'
        ]

        argument :name, desc: 'pod name', required: true
        argument :command, type: :array, desc: 'command to be executed inside the pod'

        def call(name: nil, command: [], **)
          pod_id = Pods.get_first_pod_id(name)
          raise 'Pod not found' if pod_id.nil?

          command = ['bash'] if command.empty?

          @command_builder.append('exec -it')
          @command_builder.append(pod_id)
          @command_builder.append("-- #{command.join(' ')}")
          @executor.execute!
        end
      end
    end
  end
end

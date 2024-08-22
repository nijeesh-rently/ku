# frozen_string_literal: true

module Ku
  module CLI
    module Commands
      # Command to get logs from a pod
      class Logs < Base
        desc 'get logs from a pod'

        example [
          'armor                                          # get all logs from armor pod',
          "armor 'login error'                            # get all logs from armor pod which contains 'login error'"
        ]

        argument :name, desc: 'pod name', required: true
        argument :filter, desc: 'filter to grep the logs by'

        def call(name: nil, filter: nil, **)
          pod_id = Pods.get_first_pod_id(name)
          raise 'Pod not found' if pod_id.nil?

          @command_builder.append('logs -f')
                          .append(pod_id)
          @command_builder.append("| grep #{filter}") if filter
          @executor.execute!(return_output: false)
        end
      end
    end
  end
end

# frozen_string_literal: true

module Ku
  module CLI
    module Commands
      module Secrets
        # Command to get env variables from a pod
        class Get < Base
          desc 'get env variables from a pod'

          example [
            'armor                                    # get all env variables from my-pod',
            "rently DATABASE                          # get all env variables from rently pod which contains 'DATABASE'"
          ]

          argument :name, desc: 'pod name', required: true
          argument :filter, desc: 'filter to grep the environment variables by'

          def call(name: nil, filter: nil, return_output: false, **)
            @command_builder.append("get secret #{name}")
            # rubocop:disable Layout/LineLength
            @command_builder.append("-o go-template='{{ range $key, $value := .data }}{{ printf \"%s=%s\\n\" $key ($value | base64decode) }}{{ end }}'")
            # rubocop:enable Layout/LineLength
            @command_builder.append("| grep -i #{filter}") if filter
            @executor.execute!(return_output: return_output, print_output: false)
          end

          def self.get_envs_for_pod(podname)
            output = new.call(name: podname, return_output: true)
            # if no value after the = then add empty string
            output.split("\n").map do |line|
              key, value = line.split('=')
              [key, value || '']
            end.to_h
          end
        end
      end
    end
  end
end

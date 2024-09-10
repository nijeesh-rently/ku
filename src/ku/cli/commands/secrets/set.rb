# frozen_string_literal: true

module Ku
  module CLI
    module Commands
      module Secrets
        # Command to set env variables from a pod
        class Set < Base
          require 'json'
          desc 'set env variables in a pod'

          example [
            "my-pod 'ENV_VAR1=value1 ENV_VAR2=value2 ENV_VAR3=value3'"
          ]

          argument :name, desc: 'pod name', required: true
          argument :envs, type: :array, desc: 'env variables to be updated', required: true

          def call(name: nil, envs: nil, **)
            envs_hash = parse_envs(envs)

            raise 'Invalid environment variable format' unless envs_hash

            puts "this will update the following envs in #{name}. Press Y/y to continue"

            envs_hash.each_with_index do |(key, value), index|
              puts "#{index + 1}. \t #{key} = #{value}"
            end

            return unless $stdin.gets.chomp.casecmp('y').zero?

            apply_envs(envs_hash, name)
          end

          private

          def apply_envs(envs, name)
            json_envs = JSON.generate(envs)
            @command_builder.append("patch secret #{name}")
            @command_builder.append('--type merge')
            @command_builder.append("-p '{\"stringData\": #{json_envs}}'")
            @executor.execute!
          end

          def parse_envs(envs)
            envs.each_with_object({}) do |pair, hash|
              key, value = pair.split('=', 2)
              return nil unless key && value

              hash[key] = value
            end
          end
        end
      end
    end
  end
end

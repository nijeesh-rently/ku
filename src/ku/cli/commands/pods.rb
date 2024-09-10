# frozen_string_literal: true

module Ku
  module CLI
    module Commands
      # Command to list pods from a namespace
      class Pods < Base
        desc 'List all pods'

        example [
          '                                                    # list all pods',
          'rently                                              # list all pods with name rently in it',
          'armor --running                                     # list all running pods of armor'
        ]

        argument :name, desc: 'pod name filter'
        option   :only_name, desc: 'only show pod name', type: :boolean
        option   :stdout, desc: 'print the result', type: :boolean
        option   :running, desc: 'show only running', type: :boolean

        def call(name: nil, only_name: false, stdout: true, running: true, **)
          @command_builder.append('get pods --no-headers')
          @command_builder.append('--field-selector=status.phase=Running') if running
          @command_builder.append('| awk \'{print $1}\'') if only_name
          @command_builder.append("| grep #{name}") if name
          @executor.execute!(return_output: stdout)
        end

        def self.get_first_pod_id(name)
          pods = fetch_pods(name)

          return pods.first if pods.size == 1

          web_pod = find_web_pod(pods)
          return web_pod if web_pod

          handle_multiple_pods(pods)
        end

        def self.fetch_pods(name)
          pods = new.call(name: name, only_name: true)&.split("\n")
          raise 'Pod not found' if pods.empty?

          pods
        end

        def self.find_web_pod(pods)
          pods.find { |pod| pod.include?('-web') }
        end

        def self.handle_multiple_pods(pods)
          puts "\n\nMultiple pods found:"

          pods.each_with_index { |pod, index| puts "#{index}: \t #{pod}" }
          print "\nPlease select the pod index you want to log into: "

          user_input = $stdin.gets.chomp
          index = validate_user_input(user_input, pods.size)
          pods[index]
        end

        def self.validate_user_input(user_input, pods_size)
          is_number = user_input.match?(/^\d+$/)
          raise 'Invalid input' unless is_number

          index = user_input.to_i
          raise 'Invalid input' if index.negative? || index >= pods_size

          index
        end
      end
    end
  end
end

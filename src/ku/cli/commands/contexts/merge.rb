# frozen_string_literal: true

require 'yaml'
require 'fileutils'

module Ku
  module CLI
    module Commands
      module Contexts
        # Merges configuration files for kubectl and stores it in the default location
        class Merge < Base

          desc 'Merges configuration files for kubectl and stores it in the default location'

          example [
            'merge ~/Download/config1.yaml ~/Download/config2.yaml'
          ]

          argument :configs, type: :array, desc: 'namespace to switch to', required: true

          def call(configs: [], **)
            @command_builder.append('config view --minify --raw')
            output = @executor.execute!(return_output: true)

            config = ::YAML.safe_load(output)

            puts config
            exit if config.nil?

            configs.each do |config_file|
              config_file_content = YAML.safe_load(File.read(config_file))

              config = merge(config, config_file_content)
            end

            # copy the old config to a backup file and write the new config
            FileUtils.cp(CommandBuilder::KUBE_CONFIG_PATH, "#{CommandBuilder::KUBE_CONFIG_PATH}#{Time.now}.bak")
            File.write(CommandBuilder::KUBE_CONFIG_PATH, config.to_yaml)
          end
        end
      end
    end
  end
end

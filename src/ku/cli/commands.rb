# frozen_string_literal: true

module Ku
  module CLI
    # Command registry
    module Commands
      extend Dry::CLI::Registry

      register 'logs', Logs, aliases: ['l']
      register 'pods', Pods, aliases: ['p']
      register 'context', Context, aliases: ['c']
    end
  end
end

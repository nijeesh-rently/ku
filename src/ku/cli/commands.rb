# frozen_string_literal: true

module Ku
  module CLI
    # Command registry
    module Commands
      extend Dry::CLI::Registry

      register 'logs', Logs, aliases: ['l']
      register 'pods', Pods, aliases: ['p']

      register 'context', Context, aliases: ['c'] do |prefix|
        prefix.register 'merge', Contexts::Merge
      end

      register 'switch', Contexts::Switch, aliases: ['s']
      register 'exec', Exec, aliases: ['e']

      register 'secret', Secret, aliases: ['sec'] do |prefix|
        prefix.register 'get', Secrets::Get, aliases: ['g']
        prefix.register 'set', Secrets::Set, aliases: ['g']
      end

      register 'database', Database, aliases: ['db']
    end
  end
end

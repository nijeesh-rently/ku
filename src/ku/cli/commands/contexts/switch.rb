# frozen_string_literal: true

module Ku
  module CLI
    module Commands
      module Contexts
        # Command to switch from one namespace context to another
        class Switch < Base
          desc 'switch from one namespace context to another'

          argument :namespace, desc: 'namespace to switch to', required: true

          def call(namespace: nil, **)
            cmd = CommandBuilder::BASE_COMMAND +
                  "config --kubeconfig=/home/rently/.kube/config use-context \"#{namespace}\""
            system cmd
          end
        end
      end
    end
  end
end

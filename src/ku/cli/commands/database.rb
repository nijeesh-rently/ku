# frozen_string_literal: true

module Ku
  module CLI
    module Commands
      # Command to get env variables from a pod
      class Database < Base
        desc "connect to a postgres database by getting the env variables from a pod"

        argument :name, desc: "pod name", required: true

        def call(name: nil, **)
          envs = Secrets::Get.get_envs_for_pod(name)

          raise "DATABASE_URL not found" unless envs

          database_url = database_url(envs)
          raise "DATABASE_URL not found" unless database_url

          puts "Connecting to database: #{database_url}"
          system("psql #{database_url}")
        end

        def database_url(envs)
          envs["DATABASE_URL"] || construct_database_url_from_envs(envs)
        end

        def construct_database_url_from_envs(envs)
          "postgresql://#{database_username(envs)}:" \
          "#{database_password(envs)}@#{database_host(envs)}:#{database_port(envs)}/#{database_name(envs)}"
        end

        def database_host(envs)
          envs["DATABASE_HOST"] || envs["DB_HOST"] || envs["RDS_HOST"] || regex_hash_value(envs, /DB_HOST/)
        end

        def database_name(envs)
          envs["DATABASE_NAME"] || envs["DB_NAME"] || envs["RDS_DB_NAME"] || regex_hash_value(envs, /DB_NAME/)
        end

        def database_password(envs)
          envs["DATABASE_PASSWORD"] || envs["DB_PASSWORD"] || envs["RDS_PASSWORD"] || regex_hash_value(envs, /DB_PASS/)
        end

        def database_port(envs)
          envs["DATABASE_PORT"] || envs["DB_PORT"] || envs["RDS_PORT"] || 5432 || regex_hash_value(envs, /DB_PORT/)
        end

        def database_username(envs)
          envs["DATABASE_USERNAME"] || envs["DB_USERNAME"] || envs["RDS_USERNAME"] || regex_hash_value(envs, /DB_USER/)
        end

        private

        def regex_hash_value(hash, regex)
          hash.find { |key, value| key.match?(regex) }&.last
        end
      end
    end
  end
end

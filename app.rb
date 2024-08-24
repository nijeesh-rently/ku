# frozen_string_literal: true

require 'bundler/setup'

require_relative './zeitwerk'

Dry::CLI.new(Ku::CLI::Commands).call

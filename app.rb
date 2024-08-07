# frozen_string_literal: true

require 'bundler/setup'
Bundler.require

require_relative './zeitwerk'

Dry::CLI.new(Ku::CLI::Commands).call

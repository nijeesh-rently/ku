# frozen_string_literal: true

require 'zeitwerk'

loader = Zeitwerk::Loader.new

loader.inflector.inflect('cli' => "CLI")

loader.push_dir('./src/')

loader.setup

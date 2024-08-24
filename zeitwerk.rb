# frozen_string_literal: true

require 'zeitwerk'
require 'dry/cli'

CURRENT_DIR = File.dirname(__FILE__)

loader = Zeitwerk::Loader.new

loader.inflector.inflect('cli' => 'CLI')

loader.push_dir File.join(CURRENT_DIR, 'src')

loader.setup

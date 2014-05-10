require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'vcr_cassettes'
end

require_relative '../lib/es_console'

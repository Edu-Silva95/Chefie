ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

ENV.delete("DATABASE_URL") if ENV["DATABASE_URL"].to_s.strip.empty?
ENV.delete("DATABASE_URL_TEST") if ENV["DATABASE_URL_TEST"].to_s.strip.empty?

require "bundler/setup" # Set up gems listed in the Gemfile.
require "bootsnap/setup" unless ENV["DISABLE_BOOTSNAP"] # Speed up boot time by caching expensive operations.

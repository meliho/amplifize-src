require 'rubygems'

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
ENV["PATH"] = "/usr/local/bin:#{ENV['PATH']}"
ENV["EXECJS_RUNTIME"] = 'Node'

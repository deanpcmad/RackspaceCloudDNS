require 'time'
require 'uri'
require 'net/https'
require 'json'

require "rackspace_cloud_dns/request"
require "rackspace_cloud_dns/authenticate"
require "rackspace_cloud_dns/version"

module RackspaceCloudDns

	class << self

		# API Host. UK is default
    attr_accessor :host
    
    # API Authentication
    attr_accessor :username, :api_key
    
  end

  class Error < StandardError; end
  module Errors
    class ServiceUnavailable < Error; end
    class AccessDenied < Error; end
    class NotFound < Error; end
    class CommunicationError < Error; end
    class ValidationError < Error; end
  end

end
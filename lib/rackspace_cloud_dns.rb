require 'time'
require 'uri'
require 'net/https'
require 'json'

require "rackspace_cloud_dns/request"
require "rackspace_cloud_dns/version"

module RackspaceCloudDns

	class << self
    
    # API Authentication
    attr_accessor :account_user, :api_key
    
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
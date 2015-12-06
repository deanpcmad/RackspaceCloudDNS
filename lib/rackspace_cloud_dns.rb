require 'time'
require 'uri'
require 'net/https'
require 'json'

require "rackspace_cloud_dns/request"
require "rackspace_cloud_dns/authenticate"
require "rackspace_cloud_dns/domain"
require "rackspace_cloud_dns/record"
require "rackspace_cloud_dns/version"

module RackspaceCloudDns

	class << self

		# API Host. UK is default
    # attr_accessor :host

    # API Authentication
    attr_accessor :username, :api_key

    # Auth Token & Auth Expires
    attr_accessor :auth_token, :auth_expires

    # API DNS Endpoint
    attr_accessor :dns_endpoint

    def auth
      if self.auth_token.nil?
        RackspaceCloudDns::Authenticate.new(self.username, self.api_key)
      elsif !self.auth_expires.nil? && Time.now.utc > Time.parse(self.auth_expires)
        RackspaceCloudDns::Authenticate.new(self.username, self.api_key)
      else
        true
      end
    end
    
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
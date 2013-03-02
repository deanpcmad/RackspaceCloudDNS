module RackspaceCloudDns
  class Request

    def self.request(path, method=:get, data = {})
      req = self.new(path, method)
      req.data = data
      req.make && req.success? ? req.output : false
    end
  
    attr_reader :path, :method
    attr_accessor :data
  
    def initialize(path, method = :get)
      @path = path
      @method = method
    end
  
    def success?
      @success || false
    end
  
    def output
      @output || nil
    end

    def make
      # if RackspaceCloudDns.host
      #   uri = URI.parse([RackspaceCloudDns.host, @path].join('/'))
      # else
      #   uri = URI.parse(["https://lon.identity.api.rackspacecloud.com/v2.0/", @path].join('/'))
      # end

      # use the dns_endpoint or default to the identity api
      if RackspaceCloudDns.dns_endpoint
        uri = URI.parse([RackspaceCloudDns.dns_endpoint, @path].join('/'))
      else
        uri = URI.parse(["https://lon.identity.api.rackspacecloud.com/v2.0/", @path].join('/'))
      end

      http_request = http_class.new(uri.request_uri)
      http_request.initialize_http_header({"User-Agent" => "RackspaceCloudDnsRubyClient/#{RackspaceCloudDns::VERSION}"})
      http_request.initialize_http_header({"Accept" => "application/json"})
      http_request.initialize_http_header({"X-Auth-Token" => RackspaceCloudDns.auth_token}) if RackspaceCloudDns.auth_token
      http_request.content_type = "application/json"
    
      http = Net::HTTP.new(uri.host, uri.port)
    
      if uri.scheme == 'https'
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end

      # show detailed info about the request
      puts "[RackspaceCloudDns] Sent: #{data}"
      puts "[RackspaceCloudDns] Requesting: #{[path].join('/')} on #{uri.host}#{uri.path}"
      
    
      http_result = http.request(http_request, @data.to_json)
      if http_result.body == 'true'
        @output = true
      elsif http_result.body == 'false'
        @output = false
      else
        !http_result.body.nil? ? @output = JSON.parse(http_result.body) : @output
      end
      @success = case http_result
      when Net::HTTPSuccess
        true
      when Net::HTTPServiceUnavailable
        raise RackspaceCloudDns::Errors::ServiceUnavailable
      when Net::HTTPForbidden, Net::HTTPUnauthorized
        raise RackspaceCloudDns::Errors::AccessDenied, "Access Denied"
      when Net::HTTPNotFound
        json = JSON.parse(http_result.body)
        raise RackspaceCloudDns::Errors::NotFound, json['error']
      when Net::HTTPBadRequest, Net::HTTPUnauthorized, Net::HTTPMethodNotAllowed
        json = JSON.parse(http_result.body)
        raise RackspaceCloudDns::Errors::AccessDenied, "Access Denied'  #{json['error']}"
      else
        raise RackspaceCloudDns::Errors::CommunicationError, http_result.body
      end

      puts "[RackspaceCloudDns] Response: #{http_result.body}"



      self
    end
  
    private
  
    def http_class  
      case @method
      when :post    then Net::HTTP::Post
      when :put     then Net::HTTP::Put
      when :delete  then Net::HTTP::Delete
      else
        Net::HTTP::Get
      end
    end
  
  end
end
module RackspaceCloudDns
	class Authenticate

		def initialize(username, api_key)
			@username = username
			@api_key = api_key		
		end

		def self.new(username, api_key)
      options = {:auth => { "RAX-KSKEY:apiKeyCredentials" => {:username => username, :apiKey => api_key} } }

      result = RackspaceCloudDns::Request.request("tokens", :post, options)
		end

	end
end
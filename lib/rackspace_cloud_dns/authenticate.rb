module RackspaceCloudDns
	class Authenticate

		def initialize(username, api_key)
			@username = username
			@api_key = api_key		
		end

		def self.new(username, api_key)
      options = {:auth => { "RAX-KSKEY:apiKeyCredentials" => {:username => username, :apiKey => api_key} } }

      result = RackspaceCloudDns::Request.request("tokens", :post, options)

      # set the auth token & dns endpoint
      RackspaceCloudDns.auth_token = result["access"]["token"]["id"]
      RackspaceCloudDns.dns_endpoint = result["access"]["serviceCatalog"].last["endpoints"].first["publicURL"]

      return result
		end

	end
end
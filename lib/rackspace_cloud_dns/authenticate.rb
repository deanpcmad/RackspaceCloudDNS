module RackspaceCloudDns
	class Authenticate

		def initialize(username, api_key)
			@username = username
			@api_key = api_key		
		end

		def self.new(username, api_key)
      options = {auth: { "RAX-KSKEY:apiKeyCredentials" => {username: username, apiKey: api_key} } }

      result = RackspaceCloudDns::Request.request("tokens", :post, options)

      # set the auth token, auth expires & dns endpoint
      RackspaceCloudDns.auth_token = result["access"]["token"]["id"]
      RackspaceCloudDns.auth_expires = result["access"]["token"]["expires"]
      RackspaceCloudDns.dns_endpoint = "https://lon.dns.api.rackspacecloud.com/v1.0/#{result["access"]["token"]["tenant"]["id"]}"

      return result
		end

	end
end
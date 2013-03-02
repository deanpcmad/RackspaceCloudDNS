module RackspaceCloudDns
	class Record

		# List all records for a domain
		def self.all(domain_id)
			RackspaceCloudDns::Request.request("domains/#{domain_id}/records", :get)
		end

	end
end
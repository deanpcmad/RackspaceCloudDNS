module RackspaceCloudDns
	class Record

		# List all records for a domain
		def self.all(domain_id)
			RackspaceCloudDns::Request.request("domains/#{domain_id}/records", :get)
		end

		# Seach though all records for a domain
		def self.search(domain_id, name, type, data)
			RackspaceCloudDns::Request.request("domains/#{domain_id}/records?name=#{name}&type=#{type}&data=#{data}", :get)
		end

	end
end
module RackspaceCloudDns
	class Record

		# List all records for a domain
		def self.all(domain_id)
			RackspaceCloudDns::Request.request("domains/#{domain_id}/records", :get)
		end

		# Search though all records for a domain
		def self.search(domain_id, name, type, data)
			RackspaceCloudDns::Request.request("domains/#{domain_id}/records?name=#{name}&type=#{type}&data=#{data}", :get)
		end

		# Show a specified record for a domain
		def self.show(domain_id, record_id)
			RackspaceCloudDns::Request.request("domains/#{domain_id}/records/#{record_id}", :get)
		end

		# Create a record on a domain
		def self.create(domain_id, name, type, data, priority=nil)
			options = {:records => [:name => "#{name}.#{RackspaceCloudDns::Domain.show(domain_id)["name"]}", :type => type, :data => data, :priority => priority]}

			RackspaceCloudDns::Request.request("domains/#{domain_id}/records", :post, options)
		end

		# Edit a record for a domain
		def self.edit(domain_id, record_id, name, data, priority)
			options = {:records => [:name => "#{name}.#{RackspaceCloudDns::Domain.show(domain_id)["name"]}", :data => data, :priority => priority]}

			RackspaceCloudDns::Request.request("domains/#{domain_id}/records/#{record_id}", :put, options)
		end

		# Destroy a record
		def self.destroy(domain_id, record_id)
			RackspaceCloudDns::Request.request("domains/#{domain_id}/records/#{record_id}", :delete)
		end

	end
end
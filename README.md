# RackspaceCloudDns

A gem to interact with the [Rackspace Cloud DNS](http://www.rackspace.co.uk/cloud-dns/) API.

## Installation

Add this line to your application's Gemfile:

    gem 'rackspace_cloud_dns'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rackspace_cloud_dns

## Usage

The Rackspace Cloud API requires authentication using your username & your API Key.

In a Rails app, create a file called `config/initializers/rackspace_cloud.rb` and fill it with this info (changing it for your account, etc)

```ruby
RackspaceCloudDns.username = "user"
RackspaceCloudDns.api_key = "apikey"
```

## Commands

The RackspaceCloudDns gem is built to access all the Rackspace Cloud DNS functions. Below are a list of commands currently supported.


### Domains
#### All domains
```ruby
RackspaceCloudDns::Domain.all
```

#### Search all domains
```ruby
RackspaceCloudDns::Domain.search("mydomain.com")
```

#### Create a new domain
The TTL is set to 3600 by default and the comment is optional
```ruby
RackspaceCloudDns::Domain.create("domain_name.com", "email_address", "ttl", "comment")
```

#### Shows a specified domain & all records by the domain ID
```ruby
RackspaceCloudDns::Domain.show(123123)
```

#### Edit a domain by the domain ID
```ruby
RackspaceCloudDns::Domain.edit(123123, "email", "ttl", "comment")
```

#### Delete a domain by the domain ID
```ruby
RackspaceCloudDns::Domain.destroy(123123)
```






#### Create a new record for a domain
The TTL is set to 3600 by default and the comment is optional
```ruby
RackspaceCloudDns::Domain.create_record(123123, "subdomain", "A", "192.168.1.1")


## Contributing

Fork this project, make any changes and create a pull request :)
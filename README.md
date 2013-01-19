# CDD - Collaborative Drug Discovery ![Build Status](https://travis-ci.org/cpetersen/cdd.png?branch=master)

Collaborative Drug Discovery is a web based tool for storing and sharing pharmaceutical research. This is a ruby wrapper for their API.

## Installation

Add this line to your application's Gemfile:

    gem 'cdd'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cdd

## Usage

Setup your client:

```ruby
require 'cdd'
cdd = CDD::Client.new(YOUR_TOKEN)
```

## Vaults
Retrieve your vaults

```ruby
vaults = cdd.vaults
```

Returns a list of vault objects that look like:
```ruby
[{"name"=>"Your Vault Name", "id"=>1234}]
```

## Projects
Given a vault object, you can retrieve it's project list:
```ruby
projects = vaults.first.projects
```

Returns a list of project objects that look like:
```ruby
[{"name"=>"Your Project Name", "id"=>1234}]
```

## Searches
Given a vault object, you can retrieve it's searches list:
```ruby
projects = vaults.first.searches
```

Returns a list of searches objects that look like:
```ruby
[{"name"=>"Your Search Name", "id"=>1234}]
```

## Exporting
With a ```Search``` object and one or more ```Project``` objects, you can export matching data.

### Synchronous Export
The simplest way to export data is using the ```Search#export``` method. The CDD API is asynchronous, this method wraps the API in a synchronous method. You can use in two ways:

```ruby
require 'cdd'

cdd = CDD::Client.new(YOUR_TOKEN)
vaults = cdd.vaults
vault = vaults.first
search = vault.searches.first
projects = vault.projects
data = search.export(projects, "csv") # The second parameter defaults to CSV and can be omitted.
puts data
```

Or by using the block syntax, this time in SDF format:

```ruby
require 'cdd'

cdd = CDD::Client.new(YOUR_TOKEN)
vaults = cdd.vaults
vault = vaults.first
search = vault.searches.first
projects = vault.projects
search.export(projects, "sdf") do |data|
  puts data
end
```

### Asynchronous Export

The synchronous export method is provided as a courtesy. If you could be exporting any non-trivial amount of data, you should use the aynchronous method.

To begin an export using the method ```Search#start_export```. This will return an ```Export``` object which can be polled or used to retrieve data.

```ruby
require 'cdd'

cdd = CDD::Client.new(YOUR_TOKEN)
vaults = cdd.vaults
vault = vaults.first
search = vault.searches.first
projects = vault.projects
export = search.start_export(projects, "sdf")
export_state = export.poll
puts export_state["status"]
```

When ```export.poll["status"] == "finished"``` the export is complete and can be downloaded. You retrieve the data with the following method:

```ruby
export.data
```

That will return a string containing either the CSV or SDF results.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

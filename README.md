# CDD - Collaborative Drug Discovery

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

Retrieve your vaults

```ruby
vaults = cdd.vaults
```

Returns a list of vault objects that look like:
```ruby
[{"name"=>"Your Vault Name", "id"=>1234}]
```

With a vault object, you can retrieve it's project list:
```ruby
projects = vaults.first.projects
```

Returns a list of project objects that look like:
```ruby
[{"name"=>"Your Project Name", "id"=>1234}]
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

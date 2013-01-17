# Cdd

TODO: Write a gem description

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
cdd.vaults
```

Returns
```
[{"name"=>"Your Vault Name", "id"=>1234}]
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

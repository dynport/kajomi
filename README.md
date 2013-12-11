# Kajomi

Unofficial wrapper for the Kajomi Mail API.

## Installation

Add this line to your application's Gemfile:

    gem 'kajomi'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kajomi

## Usage

### Fetch all lists from Kajomi Mail

Return an array of Kajomi::Entities::List

``` ruby
require 'rubygems'
require 'kajomi'

api_client = Kajomi::ApiClient.new(shared_key, secret_key)
lists = api_client.get_lists
```

### Using Kajomi with the [Mail](http://rubygems.org/gems/mail) library

You can use Kajomi with the `mail` gem.

``` bash
gem install mail
```

To send a `Mail::Message` via Kajomi you’ll need to specify `Mail::Kajomi` as a delivery method for the message and specify the secret key and shared key:

``` ruby
message = Mail.new do
  # ...
  delivery_method Mail::Kajomi, secret_key: 'your-secret-key', shared_key: 'your-shared-key'
end
```

#### Plain text message

``` ruby
require 'rubygems'
require 'kajomi'
require 'mail'

message = Mail.new do
  from 'sender@example.com'
  to 'recipient@example.com'
  subject 'My Subject'
  body 'Hello World!'

  delivery_method Mail::Kajomi, secret_key: 'your-secret-key', shared_key: 'your-shared-key'
end

message.deliver
```

### Using Kajomi with ActionMailer / Rails

To use Kajomi as a ActionMailer adapter see the `kajomi-rails` gem

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

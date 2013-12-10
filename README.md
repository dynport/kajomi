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

### Using Kajomi with the [Mail](http://rubygems.org/gems/mail) library

You can use Kajomi with the `mail` gem.

``` bash
gem install mail
```

To send a `Mail::Message` via Kajomi you’ll need to specify `Mail::Kajomi` as a delivery method for the message and specify the api key and user name:

``` ruby
message = Mail.new do
  # ...
  delivery_method Mail::Kajomi, api_key: 'your-api-key', user: 'your-user-name'
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

  delivery_method Mail::Kajomi, api_key: 'your-api-key', user: 'your-user-name'
end

message.deliver
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

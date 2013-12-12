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
api_client = Kajomi::ApiClient.new(shared_key, secret_key)
lists = api_client.get_lists
```

### Query users

Find users by attribute and return an array of Kajomi::Entities::User:

``` ruby
list = Kajomi::Entities::List.new(listnum: 3)
client = Kajomi::ApiClient.new(shared_key, secret_key)
users = client.query_users(list, "email", "<some-email-address>")
```

### Duplicate a list

Duplicate an existing list (identified by listnum) and return the new list as an Kajomi::Entities::List object:

``` ruby
list = Kajomi::Entities::List.new(listnum: 3)
api_client = Kajomi::ApiClient.new(shared_key, secret_key)
new_list = api_client.duplicate_list(list, "My new list")
```

### Import users to a list

Import an array of users into an existing list:

``` ruby
users = []
users << Kajomi::Entities::User.new(email: "manuel.boy@dynport.de", firstname: "Manuel", lastname: "Boy")
list = Kajomi::Entities::List.new(listnum: "<some-list-number>")
client = Kajomi::ApiClient.new(shared_key, secret_key)
response = client.import_users(list, users)
```

### Remove users

Remove users from the system identified by their uid:

``` ruby
users = []
users << Kajomi::Entities::User.new(uid: "<some-uid>")
client = Kajomi::ApiClient.new(shared_key, secret_key)
response = client.remove_users(users)
```

*Note: When removing users the API return typically an empty string and not a valid JSON response*

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

# BookscanClient

Unofficial bookscan client library for ruby

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bookscan_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bookscan_client

## Usage

```ruby
require "bookscan_client"

client = BookscanClient.new
client.login("user@example.com", "password")

books = client.books
...
```

## Contributing

1. Fork it ( https://github.com/hogelog/bookscan-client-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

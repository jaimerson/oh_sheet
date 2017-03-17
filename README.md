# OhSheet
OhSheet is a Rails mountable engine to import xlsx data into ActiveRecord models.
So that you don't have to deal with it directly.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'oh_sheet'
```

And then execute:
```bash
$ bundle
```

Install the migrations with:
```bash
$ rails oh_sheet:install:migrations
```

And then run:
```bash
$ rake db:migrate
```

## Usage
Mount the engine in your `config/routes.rb` file:

```ruby
# config/routes.rb

mount OhSheet::Engine => "/importer"
```

Now if you have, for instance, a `Contact` model in your app,
you can send a POST request to `/importer/import/contact` with
a param named `file_to_import`, which must be a xlsx file.

If you have a spreadsheet in which the headers match the model's
attribute names, you're all set!

If that's not the case, or if the structure of the resource is
more complex, you need to create a `ContactParser` class that
must receive the attributes hash in the initializer and return
a valid `Contact` attributes hash in the `#attributes` method.

## Contributing
Clone and send a pull request.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

# Summary

Hearsay is a plugin for Ruby On Rails that allows attributes of a model to loosely reference other models.

# Installation

Add the gem to your Gemfile:

```
gem 'hearsay'
```

Run the generator to get the migration, and then migrate your database:

```sh
rails g hearsay
rake db:migrate
```

# Useage

Hearsay gives you two new class methods on your models:

* references association_name, attribute, options
* referenced_by association_name, options

For complete usage, check the [rdoc](http://something-here.com/documentation).


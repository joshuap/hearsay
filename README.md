# Summary

Hearsay is a plugin for Ruby On Rails that allows attributes of a model to loosely
reference other models.

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

* references association_name, options
* referenced_by association_name, options

The best way to explain the behavior is by example. Say I have a help desk app with the
following models:

```ruby
class Issue < ActiveRecord::Base
  has_many :comments, :polymorphic => true
  referenced_by :referencing_comments, :method => :body, :class_name => 'Comment'
  ...
end
```

```ruby
class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  references :issues, :method => :body, :matcher => /#([0-9]+)/i, :finder => :find_by_number
  ...
end
```

```ruby
Issue.create(:number => 1)

issue = Issue.create(:number => 2)
issue.comments.create(:body => 'This comment also references Issue #1.')
```

When the comment on issue #2 is created, a Reference object is automatically created that also
connects the comment to issue #1. This can be used to link to related issues in HTML output,
or for any other situation where you might want to get at the originally referenced objects
without re-scanning the body attribute. This is also handy if you want to search for comments
that reference a specific issue, for instance.

# To do

* documentation
* tests
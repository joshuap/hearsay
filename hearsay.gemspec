## This is the rakegem gemspec template. Make sure you read and understand
## all of the comments. Some sections require modification, and others can
## be deleted if you don't need them. Once you understand the contents of
## this file, feel free to delete any comments that begin with two hash marks.
## You can find comprehensive Gem::Specification documentation, at
## http://docs.rubygems.org/read/chapter/20

Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.rubygems_version = '1.3.5'

  ## Leave these as is they will be modified for you by the rake gemspec task.
  ## If your rubyforge_project name is different, then edit it and comment out
  ## the sub! line in the Rakefile
  s.name              = 'hearsay'
  s.version           = '0.0.1'
  s.date              = '2012-01-23'
  # s.rubyforge_project = 'hearsay'

  ## Make sure your summary is short. The description may be as long
  ## as you like.
  s.summary     = "Models talking about models"
  s.description = "Hearsay is a plugin for Ruby On Rails that allows attributes of a model to loosely reference other models."

  ## List the primary authors. If there are a bunch of authors, it's probably
  ## better to set the email to an email list or something. If you don't have
  ## a custom homepage, consider using your GitHub URL or the like.
  s.authors  = ["Joshua Wood"]
  s.email    = 'josh@joshuawood.net'
  s.homepage = 'http://joshuawood.net/'

  ## This gets added to the $LOAD_PATH so that 'lib/NAME.rb' can be required as
  ## require 'NAME.rb' or'/lib/NAME/file.rb' can be as require 'NAME/file.rb'
  s.require_paths = %w[lib]

  ## This sections is only necessary if you have C extensions.
  # s.require_paths << 'ext'
  # s.extensions = %w[ext/extconf.rb]

  ## If your gem includes any executables, list them here.
  # s.executables = ["name"]

  ## Specify any RDoc options here. You'll want to add your README and
  ## LICENSE files to the extra_rdoc_files list.
  s.rdoc_options = ["--charset=UTF-8", "--markup=tomdoc"]
  s.extra_rdoc_files = %w[README.md LICENSE]

  ## List your runtime dependencies here. Runtime dependencies are those
  ## that are needed for an end user to actually USE your code.
  # s.add_dependency('DEPNAME', [">= 1.1.0", "< 2.0.0"])

  ## List your development dependencies here. Development dependencies are
  ## those that are only needed during development
  s.add_development_dependency("bundler", ["~> 1.0.0"])
  s.add_development_dependency("sqlite3")

  ## Leave this section as-is. It will be automatically generated from the
  ## contents of your Git repository via the gemspec task. DO NOT REMOVE
  ## THE MANIFEST COMMENTS, they are used as delimiters by the task.
  # = MANIFEST =
  s.files = %w[
    Gemfile
    LICENSE
    README.md
    Rakefile
    app/models/reference.rb
    hearsay.gemspec
    lib/generators/hearsay_generator.rb
    lib/generators/templates/hearsay_create_references.rb
    lib/hearsay.rb
    lib/hearsay/engine.rb
    lib/hearsay/referenceable.rb
    lib/hearsay/referencer.rb
    lib/hearsay/version.rb
    lib/tasks/hearsay_tasks.rake
    test/dummy/Rakefile
    test/dummy/app/assets/javascripts/application.js
    test/dummy/app/assets/stylesheets/application.css
    test/dummy/app/controllers/application_controller.rb
    test/dummy/app/helpers/application_helper.rb
    test/dummy/app/mailers/.gitkeep
    test/dummy/app/models/.gitkeep
    test/dummy/app/views/layouts/application.html.erb
    test/dummy/config.ru
    test/dummy/config/application.rb
    test/dummy/config/boot.rb
    test/dummy/config/database.yml
    test/dummy/config/environment.rb
    test/dummy/config/environments/development.rb
    test/dummy/config/environments/production.rb
    test/dummy/config/environments/test.rb
    test/dummy/config/initializers/backtrace_silencers.rb
    test/dummy/config/initializers/inflections.rb
    test/dummy/config/initializers/mime_types.rb
    test/dummy/config/initializers/secret_token.rb
    test/dummy/config/initializers/session_store.rb
    test/dummy/config/initializers/wrap_parameters.rb
    test/dummy/config/locales/en.yml
    test/dummy/config/routes.rb
    test/dummy/lib/assets/.gitkeep
    test/dummy/log/.gitkeep
    test/dummy/public/404.html
    test/dummy/public/422.html
    test/dummy/public/500.html
    test/dummy/public/favicon.ico
    test/dummy/script/rails
    test/hearsay_test.rb
    test/test_helper.rb
  ]
  # = MANIFEST =

  ## Test files will be grabbed from the file list. Make sure the path glob
  ## matches what you actually use.
  s.test_files = s.files.select { |path| path =~ /^test\/test_.*\.rb/ }
end
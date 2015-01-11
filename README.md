[![Build Status](https://travis-ci.org/tedconf/front_end_builds.svg)](https://travis-ci.org/tedconf/front_end_builds)

# FrontEndBuilds

**Warning: alpha software!**

Front-End Builds lets you easily serve remotely-hosted static (JS) applications from your Rails apps.

Benefits:
  - JS app can be deployed without redeploying your Rails app
  - Easily smoke test SHAs, branches and releases in your production environment with query params:
    http://your-app.com/my-ember-app?branch=new-feature

Features:
  - Admin interface lets you easily view, rollback and activate different app versions

The motivation for this gem came from [Luke Melia's RailsConf2014 talk](http://www.confreaks.com/videos/3324-railsconf-lightning-fast-deployment-of-your-rails-backed-javascript-app).


## Installation

Add this line to your application's Gemfile:

```
gem 'front_end_builds' 
```

And then execute:

```
$ bundle 
```

Front-End Builds brings some migrations along with it. To run, execute

```
rake front_end_builds:install:migrations
```

## Usage

First, mount the admin interface in `routes.rb`:

```rb
Rails.application.routes.draw do

  mount FrontEndBuilds::Engine, at: '/frontend-admin'

end
```

You should mount this under an authenticated route using your application's
auth strategy, as anyone with access to the admin will be able to affect the
production builds of your front end apps.

Now, to create a new app, first add a `front_end` route pointing to your app in `routes.rb`:

```rb
Rails.application.routes.draw do

  front_end 'app-name', '/app-route'

end
```

Visit the admin (at whatever URL you mounted the engine above), create a new app
named `app-name`, and you'll receive an API key with instructions on how to start
pushing builds.


## Development

**Admin**

The Admin interface is an Ember CLI app within feb. A distribution is kept
within the gem, and must be updated whenever admin code is updated.

After changing the admin app, run

```
rake admin:build
```

to store a fresh distribution.

**Running tests**

```
# Rails tests
rspec  

# Admin tests, from /admin dir
ember test
```

## TODO

* Create docs site
* Auto live setting
* make posts idempotent (i think they are), but dont insert a new row if
  it already exists.

[![Build Status](https://travis-ci.org/tedconf/front_end_builds.svg)](https://travis-ci.org/tedconf/front_end_builds)

# FrontEndBuilds

FrontEndBuilds lets you easily serve remotely-hosted static (JS) applications from your Rails apps.

Benefits:
  - JS app can be deployed without redeploying your Rails app
  - Easily smoke test SHAs, branches and releases in your production environment with query params:
    http://your-app.com/my-ember-app?branch=new-feature

Features:
  - Admin interface lets you easily view, rollback and activate different app versions (coming soon)

The motivation for this gem came from [Luke Melia's RailsConf2014 talk](http://www.confreaks.com/videos/3324-railsconf-lightning-fast-deployment-of-your-rails-backed-javascript-app).


## Installation

Add this line to your application's Gemfile:

    gem 'front_end_Builds' 

And then execute:

    $ bundle 


## Usage

1. Run migrations with

    rake front_end_builds:install:migrations

2. Add a front_end route pointing to your app in your `routes.rb`:

    ```rb
    Rails.application.routes.draw do

      front_end 'app-name', '/app-route'

      resources :users
      ...
    end
    ```

3. Make a FrontEndBuild model from the rails console:

        $ rails console
        > FrontEndBuilds::App.create(name: 'name-you-used-in-router')

Copy the API key that shows up, and POST to `/name-you-used-in-router` with that key for a new deploy.


## Development

### Running tests

```
rspec
```


## TODO

* Create docs site
* Build admin ui
* Auto live setting
* make posts idempotent (i think they are), but dont insert a new row if
  it already exists.

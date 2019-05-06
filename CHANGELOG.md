# What's new

### 1.0.1 (May 6th, 2019)
* `FrontEndBuilds::App.live_build` is now optional. This resolves issues with  Rails 5 clients that have `Rails.application.config.active_record.belongs_to_required_by_default` enabled.

### 1.0.0 (January 31, 2019)
* Support for Rails 5
* Dropping support for < Rails 5
* Support for OpenSSL Ver 2
* If a user uses a key that is not RSA an exception will now be raised

## Upgrading

To upgrade ``front_end_builds`` just set the appropriate version in your
``Gemfile`` and run ``bundle update front_end_builds``.

Once you upgrade make sure you install the latest migrations.

```
rake front_end_builds:install:migrations
rake db:migrate
```

And that's it, you now have the latest version of ``front_end_builds``.
Check the log below to see all the new features.


### 0.1.0 (Feb 23 2015)

* Asymmetrical keys used to verify builds.
  Front end builds no longer uses API keys, instead a public key is used
  to verify the build. To set this up login to your admin area and add a
  public key, for example your SSH pubkey. Make sure you update your
  ``ember-cli-front-end-builds`` to use version `0.1.0` as well.

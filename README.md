Auther
======

Easy authentication management based on Clearance and Omniauth

Description
===========

Auther aims to provide easy authentication for your Rails app, both via username/password, and via Omniauth.
The basic idea is that a user probably wants to have the multiple omniauth providers linked with the same account on your app

Omniauth is supported via an `Autherization` model. When you sign up via an Omniauth provider (i.e. Google), an instance of an `Autherization` is created and linked to your user model
If you later try to sign up on the same app via a different provider, and a match is found (i.e., the email associated with both of them is the same), then instead of a new account, you just get linked to the same one

Installation
============

Include the gem in your Gemfile. It's currently not yet released on RubyGems, so get it directly from github:
```ruby
gem 'auther', github: 'naps62/auther'
```

Bundle:
```
bundle
```

Then, run the generator. Make sure your development database is up to date (`rake db:migrate`) before doing this:
```
rails generate auther:install
```

This will do the following:

* create an `Autherization` model
* insert `Auther::Model` into your `User` model, or create one from scratch if it doesn't exist
* insert `Auther::Controller` into your `ApplicationController`
* create the necessary migrations
* create a `config/initializers/auther.rb`

OmniAuth
========

For each provider you want to use you'll have to add the corresponding omniauth provider gem to your Gemfile. A user mantained list of all supported providers is available [here](https://github.com/intridea/omniauth/wiki/List-of-Strategies)

Example:
```ruby
# Gemfile

gem 'omniauth-twitter'
gem 'omniauth-google-oauth2'
```

You will also need to provide the APP_ID and APP_SECRET for each one. The prefered way to do this is via a YAML file (by default it's `config/accounts.yml`, but this is configurable):
```yml
# config/accounts.yml

auther:
  twitter:
    app_id: 'TWITTER_APP_ID'
    app_secret: 'TWITTER_APP_SECRET'
  google_oauth2:
    app_id: 'GOOGLE_APP_ID'
    app_secret: 'GOOGLE_APP_SECRET'
```

NOTE: never checkout your APP_ID's and APP_SECRET's to version control. It is recomended to add this file to your `.gitignore``

This way, Auther will automatically detect both Twitter and Google and attempt to load their strategies. You can also use environment variables or any other method your prefer to access these keys, but you'll have to manually add the providers via the `extra_providers` configuration variable in the initializer

---

For each provider you want, run the generator for it's strategy:
```
rails generate auther:strategy twitter
```

This will generate a file `lib/auther/strategies/twitter.rb` that looks like this:
```ruby
module Auther
  module Strategies
    class Twitter < Auther::Strategies::Base

      def omniauth
        Rails.application.config.middleware.use OmniAuth::Builder do
          provider :twitter, Auther.accounts['twitter']['app_id'], Auther.accounts['twitter']['app_secret']
        end
      end

      def user
        { }
      end

      def autherization
        { }
      end

    end
  end
end
```

The `omniauth` method is what will enable the provider, and it's automatically called on startup. `Auther.accounts` is used by default, and refers the the `auther` namespace of your `config/accounts.yml` file. Change here if you get these values from somewhere else.
You can also customize the Omniauth call as you like. This will be dependent only on what that specific provider supports

The `user` and `autherization` methods define a hash of extra values you want to save for each model. Here you can access the raw OmniAuth hash via the `data` method. Let's say you want to have both a `users.twitter_handle` and a `autherizations.link` fields. You'll first have to add them to each of the tables, and make them `attr_accessible` in the models
Next, just redefine these methods like this:
```ruby
def user
  { twitter_handle: data.info.nickname }
end

def autherization
  { link: data.info.urls.twitter }
end
```

The values you have available depend on the hash given by each provider (twitter hash described [here](https://github.com/arunagw/omniauth-twitter#authentication-hash))
These values will get merged with the default ones (by default, only the provider name, uid token are stored in the autherization) when saving the records.

Configuration
=============

The following variables are available for you to change in the generated initializer:
```
accounts_file = File.join('config', 'accounts.yml')
strategies_root = File.join(Rails.root, 'lib', 'auther', 'strategies')
extra_providers = []
exclude_providers = []
mailer_sender = 'reply@example.com'
```

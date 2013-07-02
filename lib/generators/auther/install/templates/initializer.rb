Auther.configure do |config|
  # this should point to a file with all provider keys
  # defaults to 'config/accounts.yml'
  config.accounts_file = File.join('config', 'accounts.yml')

  # this is the directory where auther strategies are stored
  # it only points to the root, so 'app/services' will make
  # strategy files go to 'app/services/auther/strategies/*.rb'
  # make sure to use a directory that is in your autoload path
  config.strategies_root = File.join(Rails.root, 'lib', 'auther', 'strategies')

  # the default providers list is based on the info extracted from the accounts_file
  # and is accessible through Auther.providers
  # if for some reason you want to use a provider that is not specified in that file
  # (i.e. if you have your app_key and app_secret stored in ENV),
  # you should add those providers to the extra providers list
  # otherwise the corresponding strategy won't be loaded
  # example: config.extra_providers = [:facebook]
  config.extra_providers = []

  # use this to force some providers to not be loaded
  # even if it shows up the the accounts_file
  config.exclude_providers = []

  # the email that should be used as sender when sending emails
  config.mailer_sender = 'reply@example.com'
end

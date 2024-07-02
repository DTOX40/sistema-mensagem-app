# frozen_string_literal: true

Devise.setup do |config|
  # E-mail sender for Devise mailers
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'

  # Load and configure the ORM for Devise
  require 'devise/orm/active_record'

  # Configuration for authentication keys
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]

  # Configuration for session storage
  config.skip_session_storage = [:http_auth]

  # Password encryption settings
  config.stretches = Rails.env.test? ? 1 : 12

  # Configuration for account reconfirmation
  config.reconfirmable = true

  # Remember me settings
  config.expire_all_remember_me_on_sign_out = true

  # Password validation settings
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  # Password reset settings
  config.reset_password_within = 6.hours

  # Sign out method
  config.sign_out_via = :delete
end

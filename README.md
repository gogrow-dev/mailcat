# Mailcat

A Rails gem that integrates with [Mailcat.app](https://mailcat.app) to easily test your emails in staging and visualize them in a beautiful web interface. Instead of actually sending emails, Mailcat captures them and displays them in your Mailcat dashboard.

## Features

- 🚀 **Zero Configuration**: Automatically registers as an ActionMailer delivery method
- 📎 **Attachment Support**: Handles email attachments seamlessly
- 📧 **Multi-format Support**: Works with both HTML and plain text emails
- ⚙️ **Flexible Configuration**: Configure via environment variables or explicit configuration
- 🔒 **Secure**: Uses API keys for authentication

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mailcat'
```

And then execute:

```bash
$ bundle install
```

Or install it yourself as:

```bash
$ gem install mailcat
```

## Configuration

### Environment Variables (Recommended)

The gem automatically reads configuration from environment variables:

```bash
export MAILCAT_API_KEY=your_api_key_here
export MAILCAT_URL=https://mailcat.app
```

### Explicit Configuration

You can also configure Mailcat explicitly in your Rails initializer or environment files:

```ruby
# config/initializers/mailcat.rb
Mailcat.configure do |config|
  config.mailcat_api_key = "your_api_key_here"
  config.mailcat_url = "https://mailcat.app"
end
```

### Setting the Delivery Method

Configure ActionMailer to use the Mailcat delivery method in your environment configuration:

```ruby
# config/environments/staging.rb or config/environments/development.rb
Rails.application.configure do
  config.action_mailer.delivery_method = :mailcat
  config.action_mailer.perform_deliveries = true
end
```

## Usage

Once configured, your Rails application will automatically send all emails through Mailcat instead of actually delivering them. No changes to your mailer code are required!

```ruby
# app/mailers/user_mailer.rb
class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to our app!')
  end
end
```

The email will be captured and displayed in your Mailcat dashboard at the configured URL.

### Features in Action

- **HTML and Text Content**: Both HTML and plain text parts are captured
- **Attachments**: Email attachments are automatically uploaded and linked
- **Headers**: All email headers (from, to, cc, bcc, subject) are preserved
- **Inline Attachments**: Attachments referenced in email content are properly handled

## Requirements

- Ruby >= 3.0.0
- Rails >= 6.0.0
- ActiveSupport >= 6.0.0

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gogrow-dev/mailcat. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/gogrow-dev/mailcat/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Mailcat project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/gogrow-dev/mailcat/blob/main/CODE_OF_CONDUCT.md).

---

<div align="center">
  <p>Made with ❤️ by</p>
  <a href="https://gogrow.dev">
    <img src="assets/images/gogrow.svg" alt="GoGrow" width="120" />
  </a>
</div>

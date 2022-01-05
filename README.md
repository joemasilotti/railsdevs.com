# Rails Devs

The reverse job board for Rails developers.

![railsdevs homepage](https://user-images.githubusercontent.com/2092156/147028085-eea40303-c572-48c0-b107-0be93cce067c.png)

`railsdevs` empowers independent developers available for their next gig. It is being built around [three core values](https://railsdevs.com/about):

1. Empowering the independent developer
1. Doing everything in public
1. Creating a safe, inclusive environment

---

## Getting started

### Requirements

You need the following installed:

* Ruby 3.0 or higher
* [bundler](https://bundler.io) - `gem install bundler`
* [Redis](https://redis.io) - `brew install redis`
* [Imagemagick](https://imagemagick.org) - `brew install imagemagick`
* [Yarn](https://yarnpkg.com) - `brew install yarn`
* [Stripe CLI](https://stripe.com/docs/stripe-cli) - `brew install stripe/stripe-cli/stripe`

Optional:

* [foreman](https://github.com/ddollar/foreman) - `gem install foreman`
* [overmind](https://github.com/DarthSim/overmind) - `gem install overmind`

These are listed in `Brewfile`, which you can install via:

```bash
brew bundle install --no-upgrade
```

### Initial setup

An installation script is included with the repository that will automatically get the application setup.

```bash
bin/setup
```

## Development

Run the following to start the server and automatically build assets.

* Requires `foreman` or `overmind`
* Requires `stripe`

```bash
bin/dev
```

### Seeds

Seeding the database, either via `rails db:seed` or during `bin/setup`, creates a few accounts with developer profiles. Sign in to these with the following email addresses; all the passwords are `password`.

* `ada@example.com`
* `bjarne@example.com`
* `dennis@example.com`

There is also a single business account, `business@example.com`, that has an active subscription. Use this to test anything related to messaging.

### Stripe

You will need to configure Stripe or do a mock configuration (ie set dummy values for the last step listed below) if you are working on anything related to payments.

1. [Register for Stripe](https://dashboard.stripe.com/register) and add an account
1. Download the Stripe CLI via `brew install stripe/stripe-cli/stripe`
1. Login to the Stripe CLI via `stripe login`
1. Configure your development credentials
    1. [Create a Stripe secret key for test mode](https://dashboard.stripe.com/test/apikeys)
    1. Run `stripe listen --forward-to localhost:3000/pay/webhooks/stripe` in order to generate your webhook signing secret.
    1. [Create a product](https://dashboard.stripe.com/test/products/create) with a recurring, monthly price
    1. Generate your editable development credentials file via `EDITOR="mate --wait" bin/rails credentials:edit --environment development`. You may need to install and provide terminal access to the editor first (mate, subl, and atom should all work). If you run the code above and receive the message "New credentials encrypted and saved", without having had the opportunity to edit the file first, things have gone astray. You will need to troubleshoot this step based on your OS and desired editor, to ensure you are able to edit the development.yml file before it is encoded and saved. [See here for more details.](https://stackoverflow.com/questions/52370065/issue-to-open-credentials-file)
    1. Add the secret key, the price, and your webhook signing secret to your development credentials in the following format, and save/close the file:

```
stripe:
  private_key: sk_test_YOUR_TEST_STRIPE_KEY
  signing_secret: whsec_YOUR_SIGNING_SECRET
  price_id: price_YOUR_PRODUCT_PRICE_ID
```

## Monitoring

Application monitoring is powered by [Scout APM](https://scoutapm.com). This helps identify N+1 queries, slow queries, memory bloats, and more. Scout APM is free for open source.

## Testing

Run `rails test` to run unit/integration tests.

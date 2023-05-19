# Database seeds for local development

The goal of the database seeds is to make local development easier. They help create an environment that is representative, but not a replica, of production.

## Users

The password for all accounts is `password`.

### Developers

The "named" developers cover most states of each field on the profile. There are also 20 developers that are randomized to encourage testing of pagination.

* `developer@example.com` - The "core" developer with a complete profile, in a conversation with a business, and has sent and received messages.
* `featured@example.com` Featured at the top of search results for one week.
* `hired@example.com` - Has had contact with a business on RailsDevs.
* `minimum@example.com` - Has filled in the absolute minimum profile fields.
* `invisible@example.com` - Will not show up in search results.
* `stale@example.com` - Updates their profile over a month ago.
* `junior@example.com` - Actively looking for full-time junior roles.
* `freelancer@example.com` - Available soon, open to offers, and looking for contract work.
* `new@example.com` - A recently added profile.
* `updated@example.com` - A recently updated profile.

### Businesses

* `business@example.com` - The "core" business with an active subscription, in a conversation with a developer, and has sent and received messages.
* `lead@example.com` - A business with a complete profile but no subscription.
* `invisible@example.com` - This business was marked as spam and is hidden.
* `suspended@example.com` - This account has been suspended and they cannot use the site.

### Admins

There is one admin account that is not associated with a developer nor a business.

`admin@example.com`

## Other seeds

There are also seeds for conversations, messages, invoice requests, celebration package requests, and specialties. View these in `/db/seeds/`.

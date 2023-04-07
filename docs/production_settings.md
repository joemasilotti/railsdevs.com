# Production settings

This documents all of the configuration for the production environment.

## Environment variables

* `HOST` - Set to the production URL for route helpers, like `root_url`. RailsDevs uses `railsdevs.com`.

## Credentials

The following credentials are used in the production environment.

### AWS

AWS credentials for Active Storage uploads. `sitemaps_bucket` is a different bucket exclusively for uploading the sitemaps.

```
aws:
  access_key_id:
  region:
  secret_access_key:
  bucket:
  sitemaps_bucket:
```

### Hashids

[Hashids](https://github.com/jcypret/hashid-rails) are used to obfuscate developer profile URLs. [Set your own salt](https://github.com/jcypret/hashid-rails#configuration-optional) to ensure IDs are not guessable.

```
hashid:
  salt:
```

### Honeybadger

Error reporting is done via [Honeybadger](https://www.honeybadger.io).

```
honeybadger:
  api_key:
```

### iOS push notifications

Set any key under the `ios:` namespace to enable push notifications via APNS. All of the following keys need to be set to send notifications.

```
ios:
  bundle_identifier:
  key_id:
  team_id:
  apns_token_cert:
```

### Postmark

Transactional emails are sent via [Postmark](https://postmarkapp.com).

```
postmark_api_token:
```

### RevenueCat

RevenueCat powers in-app purchases on the iOS app. Configuration requires a product identifier for each plan, API keys, and a webhook authorization. See below for more information on setting up RevenueCat.

```
revenue_cat:
  public_key:
  private_key:
  webhook_authorization:
  product_identifiers:
    part_time:
    full_time:
```

### Scout APM

Monitoring is provided by [Scout APM](https://scoutapm.com). Reach out to [support@scoutapm.com](mailto: support@scoutapm.com) for a free plan for open source apps.

```
scout:
  key:
```

### Stripe

Stripe requires a few different keys, the credentials and the price for the business subscriptions. The signing secret is for webhooks. See below for more information on setting up Stripe.

```
stripe:
  private_key:
  signing_secret:
  price_ids:
    legacy_plan:
    part_time:
    full_time:
```

## Active Storage

The first S3 bucket is for Active Storage uploads. This requires the following ACL where `BUCKET-NAME` is the name of the bucket.

```
{
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:ListBucket",
                "s3:DeleteObject"
            ],
            "Resource": [
                "arn:aws:s3:::BUCKET-NAME/*",
                "arn:aws:s3:::BUCKET-NAME"
            ]
        }
    ]
}
```

It also requires some CORS configuration for direct uploads, copied from the [Active Storage documentation](https://edgeguides.rubyonrails.org/active_storage_overview.html#example-s3-cors-configuration).

```
[
  {
    "AllowedHeaders": [
      "*"
    ],
    "AllowedMethods": [
      "PUT"
    ],
    "AllowedOrigins": [
      "*"
    ],
    "ExposeHeaders": [
      "Origin",
      "Content-Type",
      "Content-MD5",
      "Content-Disposition"
    ],
    "MaxAgeSeconds": 3600
  }
]
```

## Heroku buildpacks for vips

vips, the library used to process images, requires custom configuration on Heroku.

Add the following buildpacks to your Heroku app, in order.

1. https://buildpack-registry.s3.amazonaws.com/buildpacks/heroku-community/apt.tgz
1. heroku/ruby
1. https://github.com/brandoncc/heroku-buildpack-vips

Note that `heroku/ruby` might already be present if you've deployed before.

## Background jobs

1. `bundle exec rake sitemap:refresh` - daily at 12:00 AM UTC
1. `bundle exec rake open_startup:refresh_metrics` - daily at 12:00 AM UTC
1. `bundle exec rake developers:calculate_search_score` - daily at 7:00 AM UTC
1. `bundle exec rake developers:notify_stale_profiles` - daily at 8:00 AM UTC
1. `bundle exec rake locations:utc_offset` - daily at 5:00 AM UTC
1. `bundle exec rake developer_digest:daily` - daily at 2:00 PM UTC
1. `bundle exec rake developer_digest:weekly` - daily at 2:00 PM UTC

## Sitemap hosting on S3

A second bucket is used for sitemaps, only. This bucket has public access enabled so Google and other search engines can fetch without authorization. On S3, this means disabling all "Block public access" settings.

<img width="1420" alt="image" src="https://user-images.githubusercontent.com/2092156/147519062-227eda4a-7b7b-4c8d-a3db-d104075bdbe4.png">

It also requires the following ACL where `SITEMAPS-BUCKET-NAME` is the name of the sitemaps bucket. Note the additional Action, `s3:PutObjectAcl`, which is required to set the object as public read.

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:ListBucket",
                "s3:DeleteObject",
                "s3:PutObjectAcl"
            ],
            "Resource": [
                "arn:aws:s3:::SITEMAPS-BUCKET-NAME/*",
                "arn:aws:s3:::SITEMAPS-BUCKET-NAME"
            ]
        }
    ]
}
```

## Analytics

RailsDevs uses [Fathom](https://usefathom.com/ref/HBTNVR) for GDPR-compliant analytics. The sites keys are identified in `config/fathom.yml`.

```
# config/fathom.yml

development: VSQTSUAQ
test: XXXXXXXX
production: CACNFAAN
```

## RevenueCat

A few settings need to be configured in [RevenueCat](https://www.revenuecat.com) for in-app purchases to work.

1. A project - RailsDevs names this "railsdevs"
1. Two products (to match the subscription tiers)
1. An App Store (iOS) app configured with the name and bundle identifier
1. The App Store Connect App-Specific Shared Secret copied to App Store Connect
1. A public and secret API key
1. An authorization header value

## Stripe

A few settings need to be configured in [Stripe](https://stripe.com) for payments to work.

1. A product - RailsDevs names this "Business subscription"
1. A recurring price for the product - RailsDevs sets this to $99/mo to match the copy on `/pricing`
1. All the [webhooks Pay requires](https://github.com/pay-rails/pay/blob/master/docs/stripe/5_webhooks.md), sent to `/pay/webhooks/stripe`

## Open startup

To generate the data for `/open` you will need to set the following additional credentials:

```
stripe:
  reporting_key:

fathom:
  api_key:
````

You can point to production to verify data (Stripe doesn't report climate contributions in dev) but make sure you use a read only access key.

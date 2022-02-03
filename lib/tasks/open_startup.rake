namespace :open_startup do
  desc "Fetch metrics from Stripe, persist, and normalize data for /open."
  task refresh_metrics: :environment do
    OpenStartup::Reporting.refresh
  end
end

Pay.setup do |config|
  config.business_name = "hirethepivot"
  config.business_address = "2625 SE Market St, Portland, OR 97214"
  config.application_name = "hirethepivot"
  config.support_email = "ben@hirethepivot.com"

  config.send_emails = true

  config.default_product_name = "hirethepivot"
  config.default_plan_name = "Business subscription"

  config.automount_routes = true
  config.routes_path = "/pay"
end

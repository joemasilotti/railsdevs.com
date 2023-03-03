class Rack::Attack
  # Throttle all requests by IP (60rpm).
  throttle("req/ip", limit: 300, period: 5.minutes) do |req|
    req.ip
  end

  # Throttle POST requests to sign in by IP address.
  throttle("logins/ip", limit: 5, period: 20.seconds) do |req|
    if req.path == "/users/sign_in" && req.post?
      req.ip
    end
  end
end

referral_code = "abc123"

referring_user = User.find_by(email: "admin@example.com")
referring_user.update!(referral_code:) unless referring_user.referral_code == referral_code

# Business referral
referred_user = User.find_by(email: "business@example.com")
SeedsHelper.create_referral!(referred_user:, referring_user:, code: referral_code)

# Developer referral
referred_user = User.find_by(email: "developer@example.com")
SeedsHelper.create_referral!(referred_user:, referring_user:, code: referral_code)

User.first.update referral_code: "abc123"

# Business referral
Referral.create(
  referred_user: User.find_by(email: "business@example.com"),
  referring_user: User.first,
  code: "abc123"
)

# Developer referral
Referral.create(
  referred_user: User.find_by(email: "zona@example.com"),
  referring_user: User.first,
  code: "abc123"
)

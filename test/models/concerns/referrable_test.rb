require "test_helper"

#  Referral diagram
#  A    B
#      / \
#     C   D
#     |
#     E
class ReferrableTest < ActiveSupport::TestCase
  def setup
    @a = create_user!("a")
    @b = create_user!("b")
    @c = create_user!("c")
    @d = create_user!("d")
    @e = create_user!("e")

    refer(@a, via: nil)
    refer(@c, via: @b)
    refer(@d, via: @b)
    refer(@e, via: @c)
  end

  test "a user who was not referred nor referred anyone" do
    assert_nil @a.referred_by
    assert_empty @a.referred_users
  end

  test "a user who referred multiple people" do
    assert_nil @b.referred_by
    assert_equal [@c, @d], @b.referred_users
  end

  test "a user who was referred and referred someone else" do
    assert_equal @b, @c.referred_by
    assert_equal [@e], @c.referred_users
  end

  test "a user who was referred by someone" do
    assert_equal @c, @e.referred_by
    assert_empty @e.referred_users

    assert_equal @b, @d.referred_by
    assert_empty @d.referred_users
  end

  def create_user!(identifier)
    User.create!(
      email: "#{identifier}@example.com",
      password: "password",
      password_confirmation: "password",
      confirmed_at: DateTime.current
    )
  end

  def refer(user, via:)
    random_code = ("A".."Z").to_a.sample(6).join
    Referral.create!(
      referring_user: via,
      referred_user: user,
      code: random_code
    )
  end
end

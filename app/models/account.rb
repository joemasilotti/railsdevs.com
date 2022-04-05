class Account < ApplicationRecord
  pay_customer

  belongs_to :owner, class_name: "User"
  has_many :account_users
  has_many :users, through: :account_users
  has_one :business, dependent: :destroy
  has_one :developer, dependent: :destroy

  has_many :conversations, ->(account) {
    unscope(where: :account_id)
      .left_joins(:business, :developer)
      .where("businesses.account_id = ? OR developers.account_id = ?", account.id, account.id)
      .visible
  }

  accepts_nested_attributes_for :account_users

  def self.build_with_owner(user)
    user.accounts.build(
      owner: user,
      account_users_attributes: [
        {role: :owner, user:}
      ]
    )
  end

  def pay_customer_name
    business&.name
  end
end

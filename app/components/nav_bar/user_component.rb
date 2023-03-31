module NavBar
  class UserComponent < ApplicationComponent
    attr_reader :user, :links

    def initialize(user, links:)
      @user = user
      @links = links
    end

    def avatarable
      user.business || user.developer
    end

    def unread_notifications?
      user.notifications.unread.any?
    end

    def admin?
      user.admin?
    end

    def hired?
      user.developer&.persisted?
    end

    def user_links
      @user_links ||= build_user_links
    end

    def admin_links
      @admin_links ||= [
        Link.new(t(".users"), admin_users_path),
        Link.new(t(".conversations"), admin_conversations_path),
        Link.new(t(".businesses_hiring_invoice_requests"), admin_businesses_hiring_invoice_requests_path),
        Link.new(t(".developers_celebration_package_requests"), admin_developers_celebration_package_requests_path),
        Link.new(t(".specialties"), admin_specialties_path),
        Link.new(t(".referrals"), admin_referrals_path),
        Link.new(t(".hiring_agreement_terms"), admin_hiring_agreements_terms_path),
        Link.new(t(".transactions"), admin_transactions_path),
        Link.new(t(".blocked_conversations"), admin_conversations_blocks_path)
      ]
    end

    private

    def build_user_links
      links = []
      links << Link.new(t(".get_started"), new_role_path) if neither?
      links << Link.new(t(".my_business_profile"), business_path(user.business)) if business?
      links << Link.new(t(".my_developer_profile"), developer_path(user.developer)) if developer?
      links << Link.new(t(".my_conversations"), conversations_path) if conversations?
      links << Link.new(t(".billing"), stripe_portal_path) if customer?
      links
    end

    def neither?
      !developer? && !business?
    end

    def business?
      user.business&.persisted?
    end

    def developer?
      user.developer&.persisted?
    end

    def conversations?
      user.conversations.any? || business?
    end

    def customer?
      user.payment_processor&.respond_to?(:billing_portal)
    end
  end
end

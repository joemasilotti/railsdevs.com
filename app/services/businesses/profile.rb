module Businesses
  class Profile
    private attr_reader :user

    def initialize(user)
      @user = user
    end

    def build_profile
      return ExistingBusiness.new(user.business) if existing_business?

      Success.new(business: user.build_business, event: nil, message: nil)
    end

    def create_profile(success_url, options)
      return ExistingBusiness.new(user.business) if existing_business?

      business.assign_attributes(options)
      if business.save
        notify_and_track(success_url)
      else
        Failure.new(business)
      end
    end

    private

    def business
      @business ||= user.build_business
    end

    def existing_business?
      user.business.present?
    end

    def notify_and_track(success_url)
      send_admin_notification
      event = create_event(success_url)
      Success.new(business:, event:, message: I18n.t("businesses.profile.created"))
    end

    def create_event(url)
      Analytics::EventTracking.new(:added_business_profile, url:).create_event
    end

    def send_admin_notification
      NewBusinessNotification.with(business:).deliver_later(User.admin)
    end

    Success = Struct.new(:business, :event, :message, keyword_init: true) do
      def success?
        true
      end
    end

    Failure = Struct.new(:business) do
      def success?
        false
      end

      def existing_business?
        false
      end
    end

    class ExistingBusiness < Failure
      def existing_business?
        true
      end
    end
  end
end

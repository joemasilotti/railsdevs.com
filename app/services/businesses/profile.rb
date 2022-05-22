module Businesses
  class Profile
    Success = Struct.new(:business, :event, :message, keyword_init: true) do
      def success?
        true
      end
    end

    Failure = Struct.new(:business) do
      def success?
        false
      end
    end

    private attr_reader :user, :success_url

    def initialize(user, success_url:)
      @user = user
      @success_url = success_url
    end

    def create_profile(options)
      business.assign_attributes(options)
      if business.save
        notify_and_track
      else
        Failure.new(business)
      end
    end

    private

    def business
      @business ||= user.build_business
    end

    def notify_and_track
      send_admin_notification
      event = create_event
      Success.new(business:, event:, message: I18n.t("businesses.profile.created"))
    end

    def create_event
      Analytics::EventTracking.new(:added_business_profile, url: success_url).create_event
    end

    def send_admin_notification
      NewBusinessNotification.with(business:).deliver_later(User.admin)
    end
  end
end

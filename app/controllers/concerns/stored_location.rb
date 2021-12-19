module StoredLocation
  extend ActiveSupport::Concern

  def stored_location
    stored_location_for(scope)
  end

  def store_location!
    store_location_for(scope, request.path)
  end

  private

  def scope
    :user
  end
end

module BusinessesHelper
  def business_attributes
    {
      user: users(:empty),
      name: "Name",
      company: "Company",
      bio: "Bio",
      avatar: active_storage_blobs(:basecamp),
      developer_notifications: :no
    }
  end
end

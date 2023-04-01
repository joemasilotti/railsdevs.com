require "test_helper"

class Developers::ExternalProfileTest < ActiveSupport::TestCase
  include DevelopersHelper

  test "should return the LinkedIn profile of a developer" do
    developer = Developer.create!(developer_attributes.merge(linkedin: "john-doe"))
    developer_external_profile = Developers::ExternalProfile.create(site: :linkedin, data: {experience: "5 years"}, developer: developer)

    result = Developers::ExternalProfile.linkedin_developer(developer)

    assert_equal developer_external_profile, result
  end

  test "should return nil if the developer does not have a LinkedIn profile" do
    developer = Developer.create!(developer_attributes.merge(linkedin: nil))

    result = Developers::ExternalProfile.linkedin_developer(developer)

    assert_nil result
  end
end

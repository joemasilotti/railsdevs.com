require "test_helper"
require "webmock/minitest"

class LinkedinProfileFetcherTest < ActiveSupport::TestCase
  include DevelopersHelper

  def setup
    @fetcher = Developers::ExternalProfiles::LinkedinProfileFetcher.new
    @developer_external_profiles_list = []
  end

  test "successfully fetches linkedin profile" do
    developer = Developer.create!(developer_attributes.merge(linkedin: "johndoe"))

    response = {
      status: 200,
      body: '{"experiences":[{"company":"Example Company"}]}'
    }

    stub_request(:get, "https://nubela.co/proxycurl/api/v2/linkedin?url=https://linkedin.com/in/johndoe/&fallback_to_cache=on-error&use_cache=if-present")
      .with(headers: {"Authorization" => "Bearer test_api_key"})
      .to_return(response)

    response_hash = JSON.parse(response[:body])
    @developer_external_profiles_list << @fetcher.external_profile(developer, mock_response(response_hash))
    @fetcher.upsert_external_profiles(@developer_external_profiles_list)

    external_profile = developer.external_profiles.find_by(site: "linkedin")
    assert_not_nil external_profile
    assert_equal "Example Company", external_profile.data["experiences"][0]["company"]
  end

  test "handles error response from API" do
    developer = Developer.create!(developer_attributes.merge(linkedin: "12345678"))

    error_response = {
      status: 404,
      body: "Not found"
    }

    stub_request(:get, "https://nubela.co/proxycurl/api/v2/linkedin?url=https://linkedin.com/in/janedoe/&fallback_to_cache=on-error&use_cache=if-present")
      .with(headers: {"Authorization" => "Bearer test_api_key"})
      .to_return(error_response)

    @developer_external_profiles_list << @fetcher.external_profile(developer, mock_response(nil, "API Error: #{error_response[:status]} - #{error_response[:body]}"))
    @fetcher.upsert_external_profiles(@developer_external_profiles_list)

    external_profile = developer.external_profiles.find_by(site: "linkedin")
    assert_not_nil external_profile
    assert_equal "API Error: #{error_response[:status]} - #{error_response[:body]}", external_profile.error
  end

  private

  def mock_response(data, error = nil)
    response = Developers::ExternalProfiles::Linkedin::Response.new(data: data, error: error)
    response.instance_variable_set(:@data, data)
    response.instance_variable_set(:@error, error)
    response
  end
end

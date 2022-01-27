require "test_helper"

class DeveloperQueryComponentTest < ViewComponent::TestCase
  test "emphasises the selected sorting" do
    query = DeveloperQuery.new(sort: :availability)
    render_inline DeveloperQueryComponent.new(query)
    assert_selector "button.text-gray-700", text: "Newest"
    assert_selector "button.text-gray-900", text: "Availability"
  end

  test "renders unique UTC offset pairs for developers" do
    query = DeveloperQuery.new({})
    render_inline DeveloperQueryComponent.new(query)

    assert_selector "input[type=checkbox][name='time_zones[]'][value=-5]"
    assert_selector "input[type=checkbox][name='time_zones[]'][value=-8]"

    assert_selector "label[for=time_zones_-5]", text: "-5 GMT"
    assert_selector "label[for=time_zones_-8]", text: "-8 GMT"
  end

  test "checks selected timezones" do
    query = DeveloperQuery.new(time_zones: ["-8"])
    render_inline DeveloperQueryComponent.new(query)

    assert_no_selector "input[checked][type=checkbox][name='time_zones[]'][value=-5]"
    assert_selector "input[checked][type=checkbox][name='time_zones[]'][value=-8]"
  end

  test "checks selected role types" do
    query = DeveloperQuery.new(role_types: ["part_time_contract", "full_time_contract"])
    render_inline DeveloperQueryComponent.new(query)

    assert_no_selector "input[checked][type=checkbox][name='role_types[]'][value=full_time_employment]"
    assert_selector "input[checked][type=checkbox][name='role_types[]'][value=part_time_contract]"
    assert_selector "input[checked][type=checkbox][name='role_types[]'][value=full_time_contract]"
  end
end

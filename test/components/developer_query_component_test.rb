require "test_helper"

class DeveloperQueryComponentTest < ViewComponent::TestCase
  test "emphasises the selected sorting" do
    query = DeveloperQuery.new(sort: :availability)
    render_inline DeveloperQueryComponent.new(query)
    assert_selector "button.text-gray-700", text: "Newest"
    assert_selector "button.text-gray-900", text: "Availability"
  end

  test "populates budget input fields from query" do
    query = DeveloperQuery.new(hourly_rate: 100, salary: 100_000)
    render_inline DeveloperQueryComponent.new(query)
    assert_selector "input[name=hourly_rate][value=100]"
    assert_selector "input[name=salary][value=100000]"
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
end

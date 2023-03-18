require "test_helper"

class Admin::SpecialtiesTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:admin)
  end

  test "creates a specialty" do
    assert_changes "Specialty.count", 1 do
      post admin_specialties_path(attributes)
    end
    assert_equal "Special", Specialty.last.name
  end

  test "updates a specialty" do
    specialty = specialties(:one)

    patch admin_specialty_path(specialty), params: {
      specialty: {name: "New name"}
    }
    assert_equal "New name", specialty.reload.name
  end

  test "validates a specialty" do
    assert_no_changes "Specialty.count" do
      post admin_specialties_path(specialty: {name: ""})
    end
    assert_response :unprocessable_entity

    specialty = specialties(:one)
    assert_no_changes "specialty.reload.name" do
      patch admin_specialty_path(specialty), params: {
        specialty: {name: ""}
      }
    end
    assert_response :unprocessable_entity
  end

  test "deletes a specialty" do
    specialty = specialties(:one)

    assert_changes "Specialty.count", -1 do
      delete admin_specialty_path(specialty)
    end
  end

  def attributes
    {specialty: {name: "Special"}}
  end
end

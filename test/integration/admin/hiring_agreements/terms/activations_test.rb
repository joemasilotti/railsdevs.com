require "test_helper"

class Admin::HiringAgreements::Terms::ActivationsTest < ActionDispatch::IntegrationTest
  test "must be signed in as an admin" do
    assert Admin::HiringAgreements::Terms::ActivationsController < Admin::ApplicationController
  end

  test "activating terms" do
    terms = HiringAgreements::Term.create!(body: "Deactivated")
    refute terms.active?

    sign_in users(:admin)
    post admin_hiring_agreements_term_activation_path(terms)

    assert terms.reload.active?
  end

  test "deactivating terms" do
    terms = hiring_agreements_terms(:active)
    assert terms.active?

    sign_in users(:admin)
    delete admin_hiring_agreements_term_activation_path(terms)

    refute terms.reload.active?
  end
end

require "test_helper"

class Admin::HiringAgreements::TermsTest < ActionDispatch::IntegrationTest
  test "must be signed in as an admin" do
    assert Admin::HiringAgreements::TermsController < Admin::ApplicationController
  end

  test "viewing all terms" do
    sign_in users(:admin)

    get admin_hiring_agreements_terms_path

    active_term = hiring_agreements_terms(:active)
    assert_term_li(active_term, active: true)
  end

  test "creating new terms" do
    sign_in users(:admin)
    get new_admin_hiring_agreements_term_path

    assert_changes "HiringAgreements::Term.count", 1 do
      post admin_hiring_agreements_terms_path, params: {
        hiring_agreements_term: {
          body: "New terms."
        }
      }
    end
    assert_equal "New terms.", HiringAgreements::Term.last.body
  end

  test "viewing terms" do
    sign_in users(:admin)

    terms = hiring_agreements_terms(:active)
    get admin_hiring_agreements_term_path(terms)

    assert_select "dd", text: terms.body
  end

  test "editing terms" do
    sign_in users(:admin)
    terms = hiring_agreements_terms(:active)

    patch admin_hiring_agreements_term_path(terms), params: {
      hiring_agreements_term: {
        body: "Updated terms."
      }
    }
    assert_equal "Updated terms.", terms.reload.body
  end

  def assert_term_li(term, active: false)
    assert_select "li##{dom_id(term)}" do
      assert_select "p", text: term.body
      assert_select "span", text: "Active" if active
    end
  end
end

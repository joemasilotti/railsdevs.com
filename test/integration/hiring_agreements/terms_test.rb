require "test_helper"

class HiringAgreements::TermsTest < ActionDispatch::IntegrationTest
  test "requires an active agreement" do
    hiring_agreements_terms(:active).deactivate!
    get hiring_agreement_terms_path
    assert_redirected_to root_path
  end

  test "renders the active agreement" do
    get hiring_agreement_terms_path
    assert_select "div", text: hiring_agreements_terms(:active).body
  end

  test "renders when it was signed" do
    sign_in users(:subscribed_business)
    get hiring_agreement_terms_path
    assert_select "div", /Signed on September 1, 2022/
  end

  test "links to PDF download when attached to signature" do
    sign_in users(:subscribed_business)
    get hiring_agreement_terms_path
    assert_select "form[action$='pdf?disposition=download']"
  end
end

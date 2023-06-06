require "test_helper"

class HiringAgreements::SignaturesTest < ActionDispatch::IntegrationTest
  test "signs the active agreement" do
    sign_in users(:empty)

    assert_changes "HiringAgreements::Signature.count", 1 do
      post hiring_agreement_signature_path, params: signature_params(signed: true)
    end

    assert_equal users(:empty), HiringAgreements::Signature.last.user
    assert_equal hiring_agreements_terms(:active), HiringAgreements::Signature.last.term
  end

  test "must be signed in" do
    get new_hiring_agreement_signature_path
    assert_redirected_to new_user_session_path
  end

  test "requires no existing signed agreement" do
    sign_in users(:subscribed_business)
    get new_hiring_agreement_signature_path
    assert_redirected_to hiring_agreement_terms_path
  end

  test "requires the agreement to be signed" do
    sign_in users(:empty)

    assert_no_changes "HiringAgreements::Signature.count" do
      post hiring_agreement_signature_path, params: signature_params(signed: false)
    end
  end

  test "redirects to the stored location" do
    sign_in users(:empty)
    post stripe_checkout_path(plan: :full_time)

    post hiring_agreement_signature_path, params: signature_params(signed: true)

    assert_redirected_to pricing_path
  end

  def signature_params(signed: true)
    {
      hiring_agreements_signature: {
        agreement: signed ? "1" : "0",
        full_name: "Kat Signer"
      }
    }
  end
end

require "test_helper"

class HiringAgreements::SignaturesTest < ActionDispatch::IntegrationTest
  test "signature successfully created after docusign success callback" do
    sign_in users(:empty)

    docusign_envelope_id = "abc123"
    mock_docusign_envelope_created_event(envelope_id: docusign_envelope_id)

    assert_changes "HiringAgreements::Signature.count", 1 do
      get docusign_signature_callback_path,
        params: docusign_callback_params(envelope_id: docusign_envelope_id, signed: true)
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
    assert_redirected_to root_path
  end

  test "requires the agreement to be signed successfully" do
    sign_in users(:empty)

    docusign_envelope_id = "abc123"

    assert_no_changes "HiringAgreements::Signature.count" do
      get docusign_signature_callback_path,
        params: docusign_callback_params(envelope_id: docusign_envelope_id, signed: false)
    end
  end

  test "redirects to the stored location" do
    sign_in users(:empty)
    post stripe_checkout_path(plan: :full_time)

    docusign_envelope_id = "abc123"
    mock_docusign_envelope_created_event(envelope_id: docusign_envelope_id)

    get docusign_signature_callback_path,
      params: docusign_callback_params(envelope_id: docusign_envelope_id, signed: true)

    assert_redirected_to pricing_path
  end

  def docusign_callback_params(envelope_id:, signed: true)
    {
      envelope_id: signed ? envelope_id : "invalid",
      event: "signing_complete"
    }
  end

  def mock_docusign_envelope_created_event(envelope_id:)
    cookies[:ds_pending_envelope_id] =
      ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base[0..31]).encrypt_and_sign(envelope_id)
  end
end

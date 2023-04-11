# frozen_string_literal: true

class Docusign::EmbeddedSigningService
  attr_reader :args

  def initialize(args)
    @args = args
  end

  def worker
    ds_ping_url = args[:ds_ping_url]
    ds_return_url = "#{ds_ping_url}/docusign/signature/callback"
    signer_client_id = args[:signer_client_id]
    signer_email = args[:signer_email]
    signer_name = args[:signer_name]
    cookies = args[:cookies]

    # Step 1. Create the envelope definition
    envelope = make_envelope(args[:signer_client_id], signer_email, signer_name)

    # Step 2. Call DocuSign to create the envelope
    envelope_api = create_envelope_api(args)

    results = envelope_api.create_envelope args[:account_id], envelope

    envelope_id = results.envelope_id
    # Store envelope_id for validating callback
    cookies[:ds_pending_envelope_id] = {value: encrypted_enevelope_id(envelope_id)}

    # Step 3. Create the recipient view for the embedded signing
    view_request = make_recipient_view_request(signer_client_id,
      ds_return_url,
      ds_ping_url,
      signer_email,
      signer_name,
      envelope_id)

    # Call the CreateRecipientView API
    results = envelope_api.create_recipient_view args[:account_id], envelope_id, view_request

    # Step 4. Redirect the user to the embedded signing
    # Don't use an iframe!
    results.url
  end

  private

  def encrypted_enevelope_id(envelope_id)
    ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base[0..31]).encrypt_and_sign(envelope_id)
  end

  def create_envelope_api(args)
    configuration = DocuSign_eSign::Configuration.new
    configuration.host = args[:base_path]
    api_client = DocuSign_eSign::ApiClient.new configuration

    api_client.default_headers["Authorization"] = "Bearer #{args[:access_token]}"
    DocuSign_eSign::EnvelopesApi.new api_client
  end

  def make_recipient_view_request(signer_client_id, ds_return_url, ds_ping_url, signer_email, signer_name, envelope_id)
    view_request = DocuSign_eSign::RecipientViewRequest.new
    view_request.return_url = "#{ds_return_url}?envelope_id=#{envelope_id}"
    view_request.authentication_method = "none"

    # Recipient information must match the embedded recipient info
    # that was used to create the envelope
    view_request.email = signer_email
    view_request.user_name = signer_name
    view_request.client_user_id = signer_client_id

    view_request.ping_frequency = "600" # seconds
    # NOTE: The pings will only be sent if the pingUrl is an HTTPS address
    view_request.ping_url = ds_ping_url # Optional setting

    view_request
  end

  def make_envelope(signer_client_id, signer_email, signer_name)
    # Step 1. Create new Envelope Definition
    envelope_definition = DocuSign_eSign::EnvelopeDefinition.new({emailSubject: "RailsDevs Hiring Agreement"})

    # Step 2. Describe the document content
    term = HiringAgreements::Term.active
    document_content = [
      "RailsDevs Hiring Agreement",
      "last updated: #{term.created_at.to_formatted_s(:calendar)}",
      "#{term.body}\n\n",
      "I Agree to these terms [sign_on_this_line]_________________"
    ]

    # Step 3. Instantiate the Document
    # Must use camelCase for setting attributes on class instantiation https://docusign.github.io/docusign-esign-ruby-client/DocuSign_eSign/Document.html#method-c-new
    # If using single-line assignment statements, use snake_case instead (e.g. doc1.file_extension = 'txt')
    doc1 = DocuSign_eSign::Document.new({
      name: "RailsDevs Hiring Agreement",
      documentBase64: Base64.encode64(document_content.join("\n\n")),
      fileExtension: "txt",
      documentId: "1"
    })

    # The order in the docs array determines the order in the envelope
    envelope_definition.documents = [doc1]
    # Step 4. Create a signer recipient to sign the document, identified by name and email
    signer1 = DocuSign_eSign::Signer.new({
      email: signer_email,
      name: signer_name,
      clientUserId: signer_client_id,
      recipientId: 1
    })
    # Step 5. The DocuSign platform searches throughout your envelope's documents for matching
    # anchor strings. So the sign_here_2 tab will be used in both document 2 and 3
    # since they use the same anchor string for their "signer 1" tabs.
    sign_here = DocuSign_eSign::SignHere.new({
      anchorString: "[sign_on_this_line]",
      anchorUnits: "pixels",
      anchorXOffset: "125",
      anchorYOffset: "0"
    })
    # Step 6. Tabs are set per recipient/signer
    tabs = DocuSign_eSign::Tabs.new({signHereTabs: [sign_here]})
    signer1.tabs = tabs
    # Step 7. Add the recipients to the envelope object
    recipients = DocuSign_eSign::Recipients.new({signers: [signer1]})

    envelope_definition.recipients = recipients
    # Request that the envelope be sent by setting status to "sent".
    # To request that the envelope be created as a draft, set status to "created"
    envelope_definition.status = "sent"
    envelope_definition
  end
end

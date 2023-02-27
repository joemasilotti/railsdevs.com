class ColdMessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_business!
  before_action :require_new_conversation!
  before_action :require_active_subscription!
  before_action :require_signed_hiring_agreement!

  def new
    message = Message.new(conversation:)
    @cold_message = cold_message(message)
  end

  def create
    message = Message.new(message_params.merge(conversation:, sender: business))
    if message.save_and_notify(cold_message: true)
      redirect_to message.conversation
    else
      @cold_message = cold_message(message)
      render :new, status: :unprocessable_entity
    end
  end

  private

  def cold_message(message)
    ColdMessage.new(message:, show_hiring_fee_terms: permissions.pays_hiring_fee?)
  end

  def require_business!
    unless business.present?
      store_location!
      redirect_to new_business_path, notice: I18n.t("errors.business_blank")
    end
  end

  def require_new_conversation!
    redirect_to conversation unless conversation.new_record?
  end

  def require_active_subscription!
    unless permissions.active_subscription?
      store_location!
      redirect_to pricing_path
    end
  end

  def require_signed_hiring_agreement!
    if current_user.needs_to_sign_hiring_agreement?
      store_location!
      redirect_to new_hiring_agreement_signature_path, notice: I18n.t("errors.hiring_agreements.cold_message")
    end
  end

  def permissions
    @permissions = current_user.permissions
  end

  def conversation
    @conversation ||= Conversation.find_or_initialize_by(developer:, business:)
  end

  def developer
    @developer ||= Developer.find(params[:developer_id])
  end

  def business
    @business = current_user.business
  end

  def message_params
    params.require(:message).permit(:body, :hiring_fee_agreement)
  end
end

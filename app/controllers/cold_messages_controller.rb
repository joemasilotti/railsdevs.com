class ColdMessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_business!
  before_action :require_new_conversation!
  before_action :require_active_subscription!

  def new
    message = Message.new(conversation:)
    @cold_message = cold_message(message)
  end

  def create
    message = Message.new(message_params.merge(conversation:, sender: business))
    if message.save_and_notify(cold_message: true)
      recede_or_redirect_to conversation_path(message.conversation)
    else
      @cold_message = cold_message(message)
      render :new, status: :unprocessable_entity
    end
  end

  private

  def recede_or_redirect_to(url, **options)
    if true # request.post? && turbo_native_app?
      redirect_to dismiss_modal_path(url: CGI.escape(url))
    else
      redirect_to url, options
    end
  end

  def cold_message(message)
    ColdMessage.new(message:, show_hiring_fee_terms: permission.pays_hiring_fee?)
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
    unless permission.active_subscription?
      store_location!
      redirect_to pricing_path
    end
  end

  def permission
    @permission = Businesses::Permission.new(current_user.subscriptions)
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

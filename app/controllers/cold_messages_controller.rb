class ColdMessagesController < ApplicationController
  before_action :authenticate_user!

  rescue_from ColdMessage::BusinessBlank, with: :redirect_to_new_business
  rescue_from ColdMessage::MissingSubscription, with: :redirect_to_pricing
  rescue_from ColdMessage::ExistingConversation, with: :redirect_to_conversation

  def new
    message = ColdMessage.new({}, developer_id:, user: current_user).build
    @context = context(message)
  end

  def create
    result = ColdMessage.new(message_params, developer_id:, user: current_user).send

    if result.success?
      redirect_to result.message.conversation
    else
      @context = context(result.message)
      render :new, status: :unprocessable_entity
    end
  end

  private

  def developer_id
    params[:developer_id]
  end

  def context(message)
    ColdMessageContext.new(
      message:,
      messageable: SubscriptionPolicy.new(current_user, message).messageable?,
      show_hiring_fee_terms: current_user.active_full_time_business_subscription?,
      tips: MarkdownRenderer.new("cold_messages/tips").render
    )
  end

  def redirect_to_new_business
    store_location!
    redirect_to new_business_path, notice: I18n.t("errors.business_blank")
  end

  def redirect_to_conversation(e)
    redirect_to e.conversation
  end

  def redirect_to_pricing
    store_location!
    redirect_to pricing_path, notice: I18n.t("errors.business_subscription_inactive")
  end

  def message_params
    params.require(:message).permit(:body, :hiring_fee_agreement)
  end
end

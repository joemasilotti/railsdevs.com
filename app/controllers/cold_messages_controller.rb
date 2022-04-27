class ColdMessagesController < ApplicationController
  before_action :authenticate_user!

  def new
    result = ColdMessage.new({}, developer_id:, user: current_user).build_message
    if result.redirect?
      redirect_to_result(result)
    else
      @context = context(result.message)
    end
  end

  def create
    result = ColdMessage.new(message_params, developer_id:, user: current_user).send_message

    if result.success?
      redirect_to result.message.conversation
    elsif result.redirect?
      redirect_to_result(result)
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

  def message_params
    params.require(:message).permit(:body, :hiring_fee_agreement)
  end
end

class ColdMessagesController < ApplicationController
  before_action :authenticate_user!

  def new
    conversation = Messaging::FindConversation.find(current_user, developer_id:)
    if conversation
      redirect_to conversation and return
    end

    result = Messaging::Message.new(current_user, developer_id:).build_message
    if result.success?
      @cold_message = result.cold_message
    else
      redirect_to_result(result)
    end
  end

  def create
    result = Messaging::Message.new(current_user, developer_id:).send_message(message_params)
    if result.success?
      redirect_to result.conversation
    elsif result.failure?
      @cold_message = result.cold_message
      render :new, status: :unprocessable_entity
    else
      redirect_to_result(result)
    end
  end

  private

  def developer_id
    params[:developer_id]
  end

  def redirect_to_result(result)
    store_location!

    if result.missing_business?
      redirect_to new_business_path, notice: result.message
    elsif result.invalid_subscription?
      redirect_to pricing_path
    end
  end

  def message_params
    params.require(:message).permit(:body, :hiring_fee_agreement)
  end
end

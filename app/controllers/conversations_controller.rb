class ConversationsController < ApplicationController
  before_action :authenticate_user!

  rescue_from ConversationPolicy::MissingBusiness, with: :missing_business
  rescue_from ConversationPolicy::AlreadyExists, with: :existing_conversation

  def new
    @conversation = build_conversation
    authorize @conversation, policy_class: ConversationPolicy
    @conversation.messages.build
  end

  def create
    @conversation = Conversation.new(conversation_params)
    authorize @conversation, policy_class: ConversationPolicy
    if @conversation.save
      redirect_to @conversation
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @conversation = Conversation.find(params[:id])
    authorize @conversation, policy_class: ConversationPolicy
  end

  private

  def missing_business(e)
    redirect_to new_business_path, notice: e.message
  end

  def existing_conversation(e)
    redirect_to e.conversation
  end

  def build_conversation
    developer = Developer.find(params[:developer_id])
    business = current_user.business
    Conversation.find_or_initialize_by(developer: developer, business: business)
  end

  def conversation_params
    params.require(:conversation).permit(
      :developer_id,
      :business_id,
      messages_attributes: [
        :body
      ]
    )
  end
end

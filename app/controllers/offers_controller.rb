# frozen_string_literal: true

class OffersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_active_subscription!

  def new
    @offer = Offer.new(conversation: @conversation)
  end

  def create
    user_not_authorized unless conversation.business?(current_user)

    @offer = Offer.new(**offer_params, conversation_id: params[:conversation_id])
    @offer.save_and_notify

    redirect_to conversation_path(params[:conversation_id])
  end

  def accept
    user_not_authorized unless conversation.developer?(current_user)

    offer.accept_and_notify
  end

  def decline
    user_not_authorized unless conversation.developer?(current_user)

    offer.decline_and_notify
  end

  private

  def require_active_subscription!
    if conversation.business?(current_user) && !current_user.permissions.active_subscription?
      redirect_to pricing_path, alert: t("errors.business_subscription_inactive")
    end
  end

  def offer
    @offer = Offer.find_by(id: params[:id])
  end

  def conversation
    @conversation ||= offer&.conversation || Conversation.visible.find(params[:conversation_id])
  end
end

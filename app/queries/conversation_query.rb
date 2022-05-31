class ConversationQuery
  include Pagy::Backend

  attr_reader :entity, :options

  alias_method :build_pagy, :pagy

  def initialize(entity = nil, options = {})
    @entity = entity
    @options = options
  end

  def pagy
    @pagy ||= query_and_paginate.first
  end

  def records
    @records ||= query_and_paginate.last
  end

  def all_records
    @all_records ||= entity.present? ? entity.conversations : Conversation.all
  end

  def replied_to_conversation_ids
    @replied_to_conversation_ids ||=
      Message.where(sender_type: "Developer", conversation: records)
        .distinct.pluck(:conversation_id)
  end

  def potential_email_conversation_ids
    @potential_email_conversation_ids ||=
      Message.where(conversation: records)
        .potential_email
        .distinct.pluck(:conversation_id)
  end

  private

  def query_and_paginate
    records = all_records
      .includes(:business, :developer)
      .order(created_at: :desc)
    @pagy, @records = build_pagy(records)
  end

  # Needed for #pagy (aliased to #build_pagy) helper.
  def params
    options
  end
end

class DeveloperProfileActionComponent < ApplicationComponent
  Action = Struct.new(:path, :icon, :cta)

  attr_reader :user

  delegate :path, :icon, :cta, to: :action

  def initialize(user)
    @user = user
  end

  private

  def action
    @action ||= get_action
  end

  def get_action
    if user&.developer&.persisted?
      update_profile_attrs
    else
      new_profile_attrs
    end
  end

  def update_profile_attrs
    Action.new(
      edit_developer_path(user.developer),
      "icons/solid/pencil.svg",
      t("developer_profile_action_component.edit_profile")
    )
  end

  def new_profile_attrs
    Action.new(
      new_developer_path,
      "icons/solid/plus_circle.svg",
      t("developer_profile_action_component.add_profile")
    )
  end
end

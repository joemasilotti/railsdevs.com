module GoalsHelper
  def data_for_goal(goal)
    {
      controller: "goals",
      action: "click->goals#complete",
      "goals-goal-value": goals[goal],
      turbo: false
    }
  end

  private

  def goals
    Rails.configuration.goals
  end
end

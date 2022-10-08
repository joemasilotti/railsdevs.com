module Activatable
  extend ActiveSupport::Concern

  class_methods do
    def active
      _active.sole
    end

    def active?
      _active.one?
    end

    def _active
      where(active: true)
    end
  end

  def activate!
    self.class.transaction do
      self.class._active.update_all(active: false)
      update!(active: true)
    end
  end

  def deactivate!
    update!(active: false)
  end
end

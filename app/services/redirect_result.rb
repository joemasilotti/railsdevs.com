class RedirectResult
  attr_reader :path, :notice

  def initialize(path, notice = nil)
    @path = path
    @notice = notice
  end

  def success?
    false
  end

  def redirect?
    true
  end
end

module PersonName
  def first_name
    name.to_s.squish.split(/\s/, 2).first
  end
end

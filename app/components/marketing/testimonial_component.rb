class Marketing::TestimonialComponent < ApplicationComponent
  def initialize(name:, title:, testimonial:)
    @name = name
    @title = title
    @testimonial = testimonial
  end
end

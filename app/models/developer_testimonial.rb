DeveloperTestimonial = Struct.new(:name, :testimonial, :title, keyword_init: true) do
  def self.all
    Rails.configuration.developer_testimonials.map { |h| new(h) }
  end
end

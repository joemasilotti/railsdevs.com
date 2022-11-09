BusinessTestimonial = Struct.new(:image, :name, :testimonial, :title, :url, keyword_init: true) do
  def self.all
    Rails.configuration.business_testimonials.map { |h| new(h) }
  end
end

Testimonial = Struct.new(:image, :name, :testimonial, :title, :url, keyword_init: true) do
  def self.all
    Rails.configuration.testimonials.map { |h| new(h) }
  end
end

class InboundEmailContent
  private attr_reader :mail

  def initialize(mail)
    @mail = mail
  end

  def content
    body.split(/^.*@railsdevs\.com>? wrote:$/).first.squish
  end

  private

  def body
    if mail.multipart?
      mail.parts.first.body.decoded
    else
      mail.decoded
    end
  end
end

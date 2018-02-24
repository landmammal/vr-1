module EmailHelper
  def email_image_tag(img, **options)
    attachments[img] = mailer_image(img)
    image_tag attachments[img].url, **options
  end

  def email_image_url(img)
    attachments[img] = mailer_image(img)
    attachments[img].url
  end

  def mailer_image(img)
    File.read( Rails.root.join("app/assets/images/mailer/#{img}") )
  end
end
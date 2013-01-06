class ReviewMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.review_mailer.reviewed_notice.subject
  #
  def reviewed_notice(collaborators, reviewer, image_version, note)
    @reviewer      = reviewer
    @image_version = image_version
    @note          = note
    to_addresses = collaborators.map(&:email)

    mail to:   to_addresses, 
         from: reviewer.email,
         subject: "#{reviewer.email} has reviewed '#{image_version.page.name}' (version #{image_version.version_number})"
  end
end

class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.secrets.decidim[:mailer_sender]
  layout 'mailer'
end

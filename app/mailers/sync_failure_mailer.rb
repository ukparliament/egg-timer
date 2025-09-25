# frozen_string_literal: true

# The mailer responsible for sending Passwordless' mails.
class SyncFailureMailer < ApplicationMailer
  def sync_fail_mail(detailed_sync_log_id)
    @detailed_sync_log = DetailedSyncLog.find(detailed_sync_log_id)
    mail(
      to: ENV['ALERT_EMAIL_ADDRESSES'],
      subject: "Sync log failure on #{ENV["ENVIRONMENT_NAME"]}"
    )
  end
end

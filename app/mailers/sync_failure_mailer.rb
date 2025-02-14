# frozen_string_literal: true

# The mailer responsible for sending Passwordless' mails.
class SyncFailureMailer < ApplicationMailer
  def sync_fail_mail(detailed_sync_log_id)
    @detailed_sync_log = DetailedSyncLog.find(detailed_sync_log_id)
    mail(
      to: 'james@shedcode.co.uk',
      subject: "Sync log failure"
    )
  end
end

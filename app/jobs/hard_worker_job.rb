class HardWorkerJob < ActiveJob::Base
  queue_as :default

  def perform(msg)
    # Do something later
    Rails.logger.debug("-------Starting working job------")
    sleep(10)
    Rails.logger.debug("-------TEST JOB: #{msg}")
  end

end

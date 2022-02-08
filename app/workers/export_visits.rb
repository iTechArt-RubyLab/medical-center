class ExportVisits
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(params)
    ExportsManager::ExportCsvVisits.new(filters: params).call
  end
end

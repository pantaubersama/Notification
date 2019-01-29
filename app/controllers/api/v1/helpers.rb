module API::V1::Helpers
  # meta response
  def present_metas resources
    total_pages  = resources.total_pages
    limit_value  = resources.limit_value
    current_page = resources.current_page
    present :meta, { total_pages: total_pages, limit_value: limit_value, current_page: current_page }, with: API::V1::Metas::Entities::Meta
  end
  def authorize_admin!
    error!("Tidak dapat mengakses API", 403) if current_user.nil? || !current_user.is_admin
  end

  def authorize_eligible_user!
    error!("Tidak dapat mengakses API", 403) unless (current_user.cluster.present? && current_user.cluster.is_eligible)
  end
end

module Provide
  class ProviderOriginAssignment < Model
    def resource_name
      "markets/#{market_id}/origins/#{origin_id}/provider_origin_assignments"
    end

    def market_id
      self[:market_id]
    end
    
    def origin_id
      self[:origin_id]
    end

    def save
      req = api_client.get(uri, provider_id: self[:provider_id], effective_on: self[:start_date])
      response = req.code == 200 ? JSON.parse(req.response_body) : []
      merge!(response.first) if response.size == 1
      super
    end
  end
end

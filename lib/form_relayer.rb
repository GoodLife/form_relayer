require "form_relayer/version"

module FormRelayer
  module ViewHelper
    def relay_received_post_params
      tags = []

      raw_params= Rack::Utils.parse_query(request.raw_post)
      raw_params.delete('utf8')
      raw_params.delete('authenticity_token')
      raw_params.each do |name, value|
        tags << hidden_field_tag(name, value)
      end

      safe_join(tags)
    end
  end
end

require "action_view"
class ActionView::Base
  include FormRelayer::ViewHelper
end

module Hancock::Goto
  module Models
    module Mongoid
      module Transfer
        extend ActiveSupport::Concern
        include ::Mongoid::Userstamp

        included do
          field :recieved_url,  type: String
          field :url,           type: String
          field :host,          type: String
          field :referer,       type: String
          field :source_ip,     type: String

          if Hancock.rails4?
            belongs_to :session, class_name: "MongoidStore::Session"
          else
            belongs_to :session, class_name: "MongoidStore::Session", optional: true
          end
          field :session_data, type: BSON::Binary
        end

        def session_data_extract
          session_data.data if session_data
        end

        def session_data_unpack
          Marshal.load(session_data_extract) if session_data
        end

        def set_session(_session)
          self.session_id = _session.id
          self.session_data = BSON::Binary.new(Marshal.dump(_session.to_hash))
        end

      end
    end
  end
end

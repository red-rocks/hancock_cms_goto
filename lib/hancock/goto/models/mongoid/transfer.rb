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

            if relations.has_key?("updater")
              belongs_to :updater, class_name: ::Mongoid::History.modifier_class_name, optional: true, validate: false
              _validators.delete(:updater)
              _validate_callbacks.each do |callback|
                if callback.raw_filter.respond_to?(:attributes) and callback.raw_filter.attributes.include?(:updater)
                  _validate_callbacks.delete(callback)
                end
              end
            end
          end
          field :session_data, type: BSON::Binary
        end

        class_methods do
          def track_history?
            false
          end
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

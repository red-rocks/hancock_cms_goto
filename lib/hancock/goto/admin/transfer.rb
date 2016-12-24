module Hancock::Goto
  module Admin
    module Transfer
      def self.config(nav_label = nil, fields = {})
        if nav_label.is_a?(Hash)
          nav_label, fields = nav_label[:nav_label], nav_label
        elsif nav_label.is_a?(Array)
          nav_label, fields = nil, nav_label
        end

        Proc.new {
          if defined?(Hancock::Feedback)
            navigation_label nav_label || I18n.t('hancock.feedback')
          else
            navigation_label nav_label || I18n.t('hancock.goto')
          end

          field :creator do
            filterable true
            pretty_value do
              unless bindings[:object].creator.blank?
                route = (bindings[:view] || bindings[:controller])
                creator = bindings[:object].creator
                model_name = creator.class.to_param.gsub("::", "~").underscore
                _url = route.rails_admin.show_path(model_name: model_name, id: creator._id)
                route.link_to(creator, _url, class: "creator_link")
              end
            end
          end
          field :created_at
          field :url do
            searchable true
            pretty_value do
              unless bindings[:object].url.blank?
                route = (bindings[:view] || bindings[:controller])
                _target = Addressable::URI.parse(bindings[:object].url).to_s
                route.link_to(_target, _target, title: _target, target: :_blank)
              end
            end
          end
          field :recieved_url
          field :host do
            searchable true
            pretty_value do
              unless bindings[:object].host.blank?
                route = (bindings[:view] || bindings[:controller])
                _target = Addressable::URI.parse(bindings[:object].host).to_s
                route.link_to(_target, _target, title: _target, target: :_blank)
              end
            end
          end
          field :referer do
            searchable true
            pretty_value do
              unless bindings[:object].referer.blank?
                route = (bindings[:view] || bindings[:controller])
                _target = Addressable::URI.parse(bindings[:object].referer).to_s
                route.link_to(_target, _target, title: _target, target: :_blank)
              end
            end
          end
          field :source_ip do
            searchable true
          end
          field :session_id do
            searchable true
            visible do
              render_object = (bindings[:controller] || bindings[:view])
              render_object and render_object.current_user.admin?
            end
          end
          field :session_data_unpack do
            searchable true
            read_only true
            visible do
              render_object = (bindings[:controller] || bindings[:view])
              render_object and render_object.current_user.admin?
            end
          end

          Hancock::RailsAdminGroupPatch::hancock_cms_group(self, fields)

          if block_given?
            yield self
          end
        }
      end
    end
  end
end

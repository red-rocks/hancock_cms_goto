require 'nokogiri'
require 'addressable'
require 'rack'

module Hancock::Goto
  class Middleware
    include Rack::Utils

    ATTRS = {
      disabled:       'data-hancock-goto-disabled',
      add_nofollow:   'data-hancock-goto-add-nofollow',
      add_noindex:    'data-hancock-goto-add-noindex',
      add_noreferrer: 'data-hancock-goto-add-noreferrer',
      add_noopener:   'data-hancock-goto-add-noopener',
      del_attrs:      'data-hancock-goto-del-attrs'
    }

    REL_ATTRS = ATTRS.dup
    REL_ATTRS.delete(:disabled)
    ATTRS.freeze
    REL_ATTRS.freeze

    def initialize(app, options = {})
      @app = app
      self
    end

    def call(env)
      status, headers, response = @app.call(env)
      headers = HeaderHash.new(headers)

      if should_process?(status, headers, env)
        begin
          content = extract_content(response)
          if Hancock::Goto.config.href_attr_regex and content =~ Hancock::Goto.config.href_attr_regex
            doc = ::Nokogiri::HTML(content)

            doc.css(Hancock::Goto.config.css_selector).each do |a|
              if (!a[ATTRS[:disabled]].blank? and !["0", "false", "no"].include?(a[ATTRS[:disabled]]))
                del_attrs(a)
                next
              end
              _href = a['href']
              if _href =~ Hancock::Goto.config.href_regex
                begin
                  _host = Addressable::URI.parse(_href).host
                  unless Hancock::Goto.config.excluded_hosts.include?(_host)
                    a['href'] = Rails.application.routes.url_helpers.hancock_goto_path(url: _href)
                    a['target'] = '_blank' if a['target'].blank?
                    set_rel_attribute(a)
                    del_attrs(a)
                  end
                rescue
                end
              end
            end

            content = doc.to_html
            headers['content-length'] = bytesize(content).to_s
            response = [content]
          end
        rescue Exception => ex
          # puts ex.message
          # puts ex.backtrace
        end
      end

      [status, headers, response]
    end

    private
    def should_process?(status, headers, env)
      cond = (env['hancock_goto_replace'].nil? || (env['hancock_goto_replace'] != false))
      cond &&
        !STATUS_WITH_NO_ENTITY_BODY.include?(status) &&
          !headers['transfer-encoding'] &&
          headers['content-type'] &&
          headers['content-type'].include?('text/html')
    end

    def extract_content(response)
      response.is_a?(Array) ? response.first : response.body
    end

    def check_attr(a, attr_name)
      Hancock::Goto.config.send(attr_name) or (!a[ATTRS[attr_name]].blank? and !["0", "false", "no"].include?(a[ATTRS[attr_name]]))
    end

    def add_attr(a, attr_name)
      rel = a['rel'].blank? ? [] : a['rel'].split(" ")
      rel << attr_name unless rel.include?(attr_name)
      a['rel'] = rel.join(" ")
      a
    end

    def add_nofollow(a)
      add_attr(a, 'nofollow') if check_attr(a, :add_nofollow)
    end

    def add_noindex(a)
      add_attr(a, 'noindex') if check_attr(a, :add_noindex)
    end

    def add_noreferrer(a)
      add_attr(a, 'noreferrer') if check_attr(a, :add_noreferrer)
    end

    def add_noopener(a)
      add_attr(a, 'noopener') if check_attr(a, :add_noopener)
    end

    def del_attrs(a)
      if check_attr(a, ATTRS[:del_attrs])
        ATTRS.values.each do |_attr|
          a.remove_attribute(_attr)
        end
      end
    end

    def set_rel_attribute(a)
      REL_ATTRS.keys.each do |meth|
        self.send(meth, a)
      end
    end

  end
end

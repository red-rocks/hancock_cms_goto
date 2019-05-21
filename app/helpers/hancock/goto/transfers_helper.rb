module Hancock::Goto::TransfersHelper
  include ::ActionView::Helpers::UrlHelper

  def link_goto(name = nil, options = nil, html_options = nil, &block)
    if block_given?
      html_options = options
      options = name
    end
    options ||= {}
    html_options ||= {}

    # include
    if options.is_a?(String)
      target_url = options 
      options = {}
    end
    target_url ||= options[:url] if options.is_a?(Hash)
    if target_url.is_a?(String) and target_url.starts_with?("//")
      request_scheme = "http" unless respond_to?(:request_scheme)
      target_url = "#{request_scheme}:#{target_url}"
    end
    # goto_url = url_for(controller: "hancock/goto/transfers", action: 'index', url: target_url)
    goto_url = Rails.application.routes.url_helpers.hancock_goto_path({url: target_url}.merge(options))
    if html_options.is_a?(Hash)
      html_options['href'] ||= target_url
      html_options['data-href'] ||= target_url
      html_options['data-gotohref'] ||= goto_url
      # html_options['onclick'] ||= "var link = this.cloneNode(false); console.log(this); console.log(link); link.href = link.getAttribute('data-gotohref'); console.log(link); link.onclick = null; console.log(link); link.click(); console.log(link); return false;"
      # html_options['onclick'] ||= "var link = this.cloneNode(true); console.log(link); link.href = link.getAttribute('data-gotohref'); console.log(link); link.removeAttribute('onclick'); console.log(link); link.click(); console.log(link); return false;"
      # html_options['onclick'] ||= "var link = this.cloneNode(true); console.log(this); console.log(link); link.href = link.getAttribute('data-gotohref'); console.log(link); link.removeAttribute('onclick'); console.log(link); window.hancock_cms.goto.fireClick(link); console.log(link); return false;"
      html_options['onclick'] ||= "var link = this.cloneNode(true); link.href = link.getAttribute('data-gotohref'); link.removeAttribute('onclick'); window.hancock_cms.goto.fireClick(link); return false;"
      html_options.reverse_merge!(Hancock::Goto.config.default_html_options)
    end

    if block_given?
      link_to(options, html_options, &block)
    else
      link_to(name, options, html_options)
    end
  end

end

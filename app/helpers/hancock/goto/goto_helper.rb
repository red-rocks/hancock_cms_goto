module Hancock::Goto::GotoHelper

  def link_goto(name = nil, options = nil, html_options = nil, &block)
    html_options, options, name = options, name, block if block_given?
    options ||= {}
    html_options ||= {}

    target_url = options.is_a?(Hash) ? url_for(options.reverse_merge({only_path: false})) : options
    goto_url = url_for({controller: "hancock/goto/transfers", action: 'index', url: target_url})
    if html_options.is_a?(Hash)
      html_options['data-href'] ||= target_url
      html_options['data-gotohref'] ||= goto_url
      html_options['onclick'] ||= "var link = this.cloneNode(true); link.href = link.getAttribute('data-gotohref'); link.click(); return false;"
      html_options.reverse_merge!(Hancock::Goto.config.default_html_options)
    end

    if block_given?
      link_to(options, html_options, &block)
    else
      link_to(name, options, html_options)
    end
  end

end

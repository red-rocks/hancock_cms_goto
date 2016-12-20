module Hancock::Goto::GotoHelper

  def link_goto(name = nil, options = nil, html_options = nil, &block)
    html_options, options, name = options, name, block if block_given?
    options ||= {}

    options.reverse_merge!({only_path: false}) if options.is_a?(Hash)
    options = {controller: "hancock/goto/transfers", action: 'index', url: url_for(options)}
    html_options.reverse_merge!(Hancock::Goto.config.default_html_options) if html_options.is_a?(Hash)

    if block_given?
      link_to(options, html_options, &block)
    else
      link_to(name, options, html_options)
    end
  end

end

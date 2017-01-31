module Hancock::Goto
  module Controllers
    module Transfers
      extend ActiveSupport::Concern

      def index
        @url = Addressable::URI.heuristic_parse(params[:url]).to_s rescue nil
        _params = params.clone
        _session = session.clone
        _request = request.clone
        Thread.new do
          referer = (_request.referer ? Addressable::URI.parse(_request.referer) : nil) rescue nil

          @transfer = transfer_class.new
          @transfer.recieved_url = _params[:url]
          @transfer.url = @url.to_s
          @transfer.host = @url.host.to_s if @url
          @transfer.referer = referer.to_s
          @transfer.source_ip = _request.env['HTTP_X_FORWARDED_FOR'] || _request.remote_ip
          if Hancock::Goto.mongoid?
            @transfer.set_session(_session)
          end
          @transfer.save
        end

        case Hancock::Goto.config.method.to_sym
        when :render_view
          render layout: false
        when :redirect_from_controller
          redirect_to @url, code: 303
        else
          redirect_to @url, code: 303
        end
      end

      def transfer_class
        Hancock::Goto::Transfer
      end

    end
  end
end

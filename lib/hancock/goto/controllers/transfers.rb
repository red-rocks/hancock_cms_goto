module Hancock::Goto
  module Controllers
    module Transfers
      extend ActiveSupport::Concern

      def index
        url = Addressable::URI.heuristic_parse(params[:url]) rescue nil
        referer = (request.referer ? Addressable::URI.parse(request.referer) : nil) rescue nil

        @transfer = transfer_class.new
        @transfer.recieved_url = params[:url]
        @transfer.url = url.to_s
        @transfer.host = url.host.to_s if url
        @transfer.referer = referer.to_s
        @transfer.source_ip = request.env['HTTP_X_FORWARDED_FOR'] || request.remote_ip
        if Hancock::Goto.mongoid?
          @transfer.session_id = session.id
          @transfer.session_data = BSON::Binary.new(Marshal.dump(session.to_hash))
        end
        @transfer.save

        redirect_to @transfer.url, code: 303
      end

      def transfer_class
        Hancock::Goto::Transfer
      end

    end
  end
end

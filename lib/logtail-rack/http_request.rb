require "logtail-rack/util/encoding"

module Logtail
  module Integrations
    module Rack
      # The HTTP server request event tracks incoming HTTP requests to your HTTP server.
      # Such as unicorn, webrick, puma, etc.
      #
      # @note This event should be installed automatically through integrations,
      #   such as the {Integrations::ActionController::LogSubscriber} integration.
      class HTTPRequest
        attr_reader :body, :content_length, :headers, :headers_json, :host, :method, :path, :port,
          :query_string, :request_id, :scheme, :service_name

        def initialize(attributes)
          @body = attributes[:body]
          @content_length = attributes[:content_length]
          @headers = attributes[:headers]
          @host = attributes[:host]
          @method = attributes[:method]
          @path = attributes[:path]
          @port = attributes[:port]
          @query_string = attributes[:query_string]
          @scheme = attributes[:scheme]
          @request_id = attributes[:request_id]
          @service_name = attributes[:service_name]

          if @headers
            @headers_json = Util::Encoding.force_utf8_encoding(@headers).to_json
          end
        end

        def message
          'Started %s "%s"' % [method, path]
        end
      end
    end
  end
end

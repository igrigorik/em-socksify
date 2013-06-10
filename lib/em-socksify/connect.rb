module EventMachine
  module Connectify
    module CONNECT
      SUCCESS_PREFIX = "HTTP/1.0 200 "

      def connect_send_handshake
        header =  "CONNECT #{@connect_target_host}:#{@connect_target_port} HTTP/1.0\r\n\r\n"
        send_data(header)
      end

      private

      def connect_parse_response
        return if @connect_data.size < SUCCESS_PREFIX.size

        unless @connect_data.start_with?(SUCCESS_PREFIX) && @connect_data.end_with?("\r\n\r\n")
          raise CONNECTError.new, "Unexpected response: #{@connect_data}"
        end

        connect_unhook
      rescue => e
        @connect_deferrable.fail e
      end
    end
  end
end

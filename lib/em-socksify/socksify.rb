module EventMachine

  module Socksify
    def socksify(host, port, username = nil, password = nil, version = 5, always_raise = false, &blk)
      @socks_target_host = host
      @socks_target_port = port
      @socks_username = username
      @socks_password = password
      @socks_version = version
      @socks_always_raise = always_raise
      @socks_callback = blk
      @socks_data = ''

      socks_hook
      socks_send_handshake
    end

    def socks_hook
      if @socks_version == 5
        extend SOCKS5
      else
        raise ArgumentError, 'SOCKS version unsupported'
      end

      class << self
        alias receive_data socks_receive_data
      end
    end

    def socks_unhook(ip = nil)
      class << self
        remove_method :receive_data
      end

      @socks_callback.call(ip)
    end

    def socks_error?
      @socks_error
    end

    def socks_error (exc)
      @socks_error = true

      if @socks_callback && !@socks_always_raise
        @socks_callback.call(exc)

        true
      else
        false
      end
    end

    def socks_receive_data(data)
      @socks_data << data
      socks_parse_response
    end
  end

end

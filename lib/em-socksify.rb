require 'eventmachine'

require 'em-socksify/socksify'
require 'em-socksify/errors'
require 'em-socksify/socks5'

module EventMachine
  def connect_through (proxy, server, port, handler, *args, &blk)
    handler.instance_eval {
      include EM::Socksify

      connected = instance_method(:connection_completed) rescue nil

      define_method :connection_completed do
        socksify(server, port, *proxy[2 .. -1]).callback {
          connected.bind(self).call if connected
        }.errback {|e|
          raise e
        }
      end
    }

    connect proxy[0], proxy[1], handler, *args, &blk
  end

  module_function :connect_through
end

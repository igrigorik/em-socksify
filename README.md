# EM-Socksify: Transparent SOCKS support for any EventMachine protocol

Dealing with SOCKS proxies is pain. EM-Socksify provides a simple shim to setup & negotiate a SOCKS5 connection for any EventMachine protocol. To add SOCKS support, all you have to do is include the module and provide your destination address.

## Example: Routing HTTP request via SOCKS5 proxy

    class Handler < EM::Connection
      include EM::Socksify

      def connection_completed
        socksify('google.ca', 80) do
          send_data "GET / HTTP/1.1\r\nConnection:close\r\nHost: google.ca\r\n\r\n"
        end
      end

      def receive_data(data)
        p data
      end
    end

    EM.run do
      EventMachine.connect SOCKS_HOST, SOCKS_PORT, Handler
    end

What's happening here? First, we open a raw TCP connection to the SOCKS proxy (after all, all data will flow through it). Then, we provide a Handler connection class, which includes "EM::Socksify". Once the TCP connection is established, EventMachine calls the **connection_completed** method in our handler. Here, we call socksify with the actual destination host & port (address that we actually want to get to), and the module does the rest.

After you call socksify, the module temporarily intercepts your receive_data callbacks, negotiates the SOCKS connection (version, authentication, etc), and then once all is done, returns the control back to your code. Simple as that.

For SOCKS proxies which require authentication, use:

    socksify(destination_host, destination_port, username, password)


## Wishlist

- IPV6 support
- SOCKS4 support

## Resources

- [SOCKS on Wikipedia](http://en.wikipedia.org/wiki/SOCKS)
- [Socksify-Ruby](https://github.com/astro/socksify-ruby) for regular Ruby TCPSocket

# License

(The MIT License)
Copyright © 2011 Ilya Grigorik
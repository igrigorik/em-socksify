require 'helper'

describe EventMachine do

  it "should negotiate a socks connection" do

    class Handler < EM::Connection
      include EM::Socksify

      def connection_completed
        socksify('google.ca', 80) do
          send_data "GET / HTTP/1.1\r\nConnection:close\r\nHost: google.ca\r\n\r\n"
        end
      end

      def receive_data(data)
        @received ||= ''
        @received << data
      end

      def unbind
        @received.size.should > 0
        @received[0,4].should == 'HTTP'
        EM.stop
      end
    end

    EM.run do
      EventMachine.connect '127.0.0.1', 8080, Handler
    end
  end

end
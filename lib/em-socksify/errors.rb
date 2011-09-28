class SOCKSError < Exception
  def self.define (message)
    Class.new(self) {
      def initialize
        super(message)
      end
    }
  end

  ServerFailure           = SOCKSError.define('general SOCKS server failure')
  NotAllowed              = SOCKSError.define('connection not allowed by ruleset')
  NetworkUnreachable      = SOCKSError.define('Network unreachable')
  HostUnreachable         = SOCKSError.define('Host unreachable')
  ConnectionRefused       = SOCKSError.define('Connection refused')
  TTLExpired              = SOCKSError.define('TTL expired')
  CommandNotSupported     = SOCKSError.define('Command not supported')
  AddressTypeNotSupported = SOCKSError.define('Address type not supported')

  def self.for_response_code(code)
    case code.is_a?(String) ? code.ord : code
    when 1 then ServerFailure
    when 2 then NotAllowed
    when 3 then NetworkUnreachable
    when 4 then HostUnreachable
    when 5 then ConnectionRefused
    when 6 then TTLExpired
    when 7 then CommandNotSupported
    when 8 then AddressTypeNotSupported
    else self
    end
  end
end

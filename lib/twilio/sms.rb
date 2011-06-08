module Twilio
  class SMS
    include Twilio::Resource
    include Twilio::Persistable
    extend  Twilio::Finder

    class << self
      private
      def prepare_params(opts) # :nodoc:
        pairs = opts.map do |k,v|
          if [:created_before, :created_after, :sent_before, :sent_after].include? k
            k = k.to_s
            # Fancy schmancy-ness to handle Twilio <= URI operator for dates
            comparator = k =~ /before$/ ? '<=' : '>='
            URI.encode("DateSent" << comparator << v.to_s)
          else
            "#{k.to_s.camelize}=#{CGI.escape v.to_s}"
          end
        end
        "?#{pairs.join('&')}"
      end
    end
  end
end

module Jeth
  class Util
    def self.underscore(s)
      s.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
    end

    def self.int_to_hex(n)
      "0x#{n.to_s(16)}"
    end
  end
end
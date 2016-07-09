require 'socket'

module Jeth
  class IpcClient < Client
    def initialize(ipcpath = default_path)
      super()
      @ipcpath = ipcpath 
    end

    def send_single(payload)
      socket = UNIXSocket.new(@ipcpath)
      socket.puts(payload)
      read = socket.gets
      socket.close
      return read
    end

    def default_path
      ["#{ENV['HOME']}/.ethereum/geth.ipc", "#{ENV['HOME']}/Library/Ethereum/geth.ipc"].each do |path|
        return path if File.exists?(path)
      end
    end
  end
end
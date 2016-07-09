require 'jeth/version'
require 'jeth/util'
require 'jeth/client'
require 'jeth/http_client'
require 'jeth/ipc_client'

module Jeth
  def self.create(host_or_ipcpath = nil)
    return IpcClient.new if host_or_ipcpath.nil?
    return IpcClient.new(host_or_ipcpath) if host_or_ipcpath.end_with? '.ipc'
    return HttpClient.new(host_or_ipcpath) if host_or_ipcpath.start_with? 'http'
    
    raise ArgumentError.new('Unable to detect client type. Please use "http://host:port" or "/path/to/geth.ipc".')
  end
end

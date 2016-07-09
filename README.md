# Jeth

Jeth is a Ethereum JSON RPC client. It supports the IPC and HTTP protocols.

## Installation

```ruby
gem 'jeth'
```

Start your Ethereum node with the desired endpoints (IPC, HTTP and/or WS). For example with Geth:

    $ geth --rpc --rpcapi "admin,debug,eth,miner,net,personal,shh,txpool,web3"

## Usage

```ruby
client = Jeth.create
client = Jeth::IpcClient.create
client = Jeth::HttpClient.create('http://foo.bar:8545')

client.eth_gas_price
 => {"jsonrpc"=>"2.0", "id"=>1, "result"=>"0x4a817c800"} 
```

`Jeth.create(host_or_ipcpath)` automatically detects if you want HTTP or IPC and will initiate the appropriate client. It will default to IPC if nothing is specified. You can also use protocol clients explicitly:

### Batching

```ruby
client.batch do
  client.eth_get_balance('0x407d73d8a49eeb85d32cf465507dd71d507100c1', 'latest')
  client.eth_get_balance('0x407d73d8a49eeb85d32cf465507dd71d507100c1', 'pending')
end

 => [{"jsonrpc"=>"2.0", "id"=>1, "result"=>"0x0"}, {"jsonrpc"=>"2.0", "id"=>2, "result"=>"0x0"}]
```

The response array is guaranteed to hold the responses in the same order as their corresponding requests were called.

## Methods

Jeth supports all methods from https://github.com/ethereum/wiki/wiki/JSON-RPC and https://github.com/ethereum/go-ethereum/wiki/Management-APIs. Method names are downcased, so for example `eth_getBlockByNumber` becomes `eth_get_block_by_number`.

## Parameters

Jeth will automagically encode integer parameters as hex. That is `client.eth_get_block_by_number(0, false)` will be sent as `{"jsonrpc":"2.0","method":"eth_getBlockByNumber","params":["0x0",false],"id":1}`.

You are free to use hex encoded parameters too `client.eth_get_block_by_number('0x0', false)`.

Note that Jeth won't prefix with '0x' if the user supplied hex encoded parameter is missing the prefix. However, at least Geth seems to tolerate unprefixed hex parameters.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/alexhanh/jeth.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


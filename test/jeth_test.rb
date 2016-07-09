require 'test_helper'

class JethTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Jeth::VERSION
  end

  def test_that_create_works
    assert_raises(ArgumentError) { Jeth.create('') }
  end

  def test_that_create_returns_ipc_client_by_default
    assert_instance_of Jeth::IpcClient, Jeth.create
  end

  def test_that_works
    [Jeth::IpcClient, Jeth::HttpClient].each do |klass|
      client = klass.new
      response = client.eth_get_block_transaction_count_by_number(0)
      expected = {"jsonrpc"=>"2.0", "id"=>1, "result"=>"0x0"}
      assert_equal expected, response
    end
  end

  def test_that_batching_works
    [Jeth::IpcClient, Jeth::HttpClient].each do |klass|
      client = klass.new
      response = client.batch do
        client.net_listening
        client.eth_block_number
      end

      assert_instance_of Array, response
      assert_equal 2, response.length
      assert_includes [true, false], response.first['result']
      assert_match /(0x)?[0-9a-f]+/i, response.last['result']
    end
  end

  def test_encode_parameters
    params = [true, false, 0, 12345, '0x7d84abf0f241b10927b567bd636d95fa9f66ae34', '0x4d5e07d4057dd0c3849c2295d20ee1778fc29d69150e8d75a07207347dce17fa', '7d84abf0f241b10927b567bd636d95fa9f66ae34']
    client = Jeth.create
    encoded_params = client.encode_params(params)
    assert_equal [true, false, '0x0', '0x3039', '0x7d84abf0f241b10927b567bd636d95fa9f66ae34', '0x4d5e07d4057dd0c3849c2295d20ee1778fc29d69150e8d75a07207347dce17fa', '7d84abf0f241b10927b567bd636d95fa9f66ae34'], encoded_params
  end
end

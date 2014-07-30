require 'helper'
require 'form_relayer'

describe FormRelayer do
  it 'has version' do
    FormRelayer.const_get('VERSION').wont_be_empty
  end

  describe '#relay_received_post_params' do
    before do
      @view = ActionView::Base.new
    end
    it 'handles post params' do
      @view.stubs(:request).returns(mock('request', raw_post:'a=1'))
      assert_equal %{<input id="a" name="a" type="hidden" value="1" />}, @view.relay_received_post_params
    end
    it 'handles post params with multiple value' do
      @view.stubs(:request).returns(mock('request', raw_post:'a=1&b=2'))
      assert_equal %{<input id="a" name="a" type="hidden" value="1" /><input id="b" name="b" type="hidden" value="2" />}, @view.relay_received_post_params
    end
    it 'handles post params which ends without value' do
      @view.stubs(:request).returns(mock('request', raw_post:'a=1&b='))
      assert_equal %{<input id="a" name="a" type="hidden" value="1" /><input id="b" name="b" type="hidden" value="" />}, @view.relay_received_post_params
    end
    it 'handles post params which has brackets in name' do
      @view.stubs(:request).returns(mock('request', raw_post:'order%5Bshipping%5D=1&order%5Bemail%5D=aloha%40example.com'))
      assert_equal %{<input id="order_shipping" name="order[shipping]" type="hidden" value="1" /><input id="order_email" name="order[email]" type="hidden" value="aloha@example.com" />}, @view.relay_received_post_params
    end
    it 'removes extra params added by Rails' do
      @view.stubs(:request).returns(mock('request', raw_post:'utf8=%E2%9C%93&authenticity_token=ABCD1234%3D&order%5Bshipping%5D=1'))
      assert_equal %{<input id="order_shipping" name="order[shipping]" type="hidden" value="1" />}, @view.relay_received_post_params
    end
  end
end

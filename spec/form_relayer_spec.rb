require 'helper'

describe FormRelayer do
  it 'has version' do
    expect(FormRelayer.const_get('VERSION')).not_to be_empty
  end

  context '#relay_received_post_params' do
    let(:view) { ActionView::Base.new }

    describe 'handles post params' do
      let(:post_params) { 'a=1' }
      before { stub_view post_params }

      it {
        expect(view.relay_received_post_params).to eq <<-html.gsub("\n", "")
<input id="a" name="a" type="hidden" value="1" />
        html
      }
    end

    describe 'handles post params with multiple value' do
      let(:post_params) { 'a=1&b=2' }
      before { stub_view post_params }

      it {
        expect(view.relay_received_post_params).to eq <<-html.gsub("\n", "")
<input id="a" name="a" type="hidden" value="1" /><input id="b" name="b" type="hidden" value="2" />
        html
      }
    end

    describe 'handles post params which ends without value' do
      let(:post_params) { 'a=1&b=' }
      before { stub_view post_params }

      it {
        expect(view.relay_received_post_params).to eq <<-html.gsub("\n", "")
<input id="a" name="a" type="hidden" value="1" /><input id="b" name="b" type="hidden" value="" />
        html
      }
    end

    describe 'handles post params which has brackets in name' do
      let(:post_params) { 'order%5Bshipping%5D=1&order%5Bemail%5D=aloha%40example.com' }
      before { stub_view post_params }

      it {
        expect(view.relay_received_post_params).to eq <<-html.gsub("\n", "")
<input id="order_shipping" name="order[shipping]" type="hidden" value="1" /><input id="order_email" name="order[email]" type="hidden" value="aloha@example.com" />
        html
      }
    end

    describe 'removes extra params added by Rails' do
      let(:post_params) { 'utf8=%E2%9C%93&authenticity_token=ABCD1234%3D&order%5Bshipping%5D=1' }
      before { stub_view post_params }

      it {
        expect(view.relay_received_post_params).to eq <<-html.gsub("\n", "")
<input id="order_shipping" name="order[shipping]" type="hidden" value="1" />
        html
      }
    end
  end
end

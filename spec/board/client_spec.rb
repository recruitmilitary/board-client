require 'spec_helper'

describe Board::Client do

  let(:client) { Board::Client.new('VALID_KEY') }

  describe "when creating" do

    context 'and missing an API key' do
      it 'should raise an error' do
        expect { Board::Client.new }.to raise_error
      end
    end

    context "with an API key" do
      it 'should not raise an error' do
        Board::Client.new('API_KEY')
      end
    end

  end

end

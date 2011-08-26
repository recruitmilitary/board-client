require 'spec_helper'

describe 'User Unsubscribe' do

  let(:board) { Board::Client.new('Bdrc3t1LaiWtygbJ4jD6') }

  context 'by email' do
    context 'when the user exists' do
      use_vcr_cassette 'unsubscribe email exists'

      it 'returns true' do
        response = board.users.unsubscribe("candidate@recruitmilitary.com")

        response.should be_true
      end
    end

    context 'when the user does not exist' do
      use_vcr_cassette 'unsubscribe email does not exist'

      it 'raises a not found error' do
        expect {
          board.users.unsubscribe("michael@jordan.com")
        }.to raise_error(Board::Request::NotFound)
      end
    end
  end

end

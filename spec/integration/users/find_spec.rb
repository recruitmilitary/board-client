require 'spec_helper'

describe 'User Find' do

  let(:board) { Board::Client.new('Bdrc3t1LaiWtygbJ4jD6') }

  context 'by id' do
    context 'when the user exists' do
      use_vcr_cassette "user exists with id"

      it 'returns a user with the correct attributes' do
        user = board.users.find(100)

        user.id.should == 100
        user.email.should == 'candidate@recruitmilitary.com'
        user.first_name.should == 'Michael'
        user.last_name.should == 'Jordan'
      end
    end

    context 'when the user does not exist' do
      use_vcr_cassette "user id does not exist"

      it 'raises a not found exception' do
        expect {
          board.users.find(42)
        }.to raise_error(Board::Request::NotFound)
      end
    end
  end

  context 'by email' do
    context 'when the user exists'
    context 'when the user does not exist'
  end

  context 'by email_md5' do
    context 'when the user exists'
    context 'when the user does not exist'
  end
end

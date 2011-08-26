require 'spec_helper'

describe 'User Find' do

  let(:board) { Board::Client.new('Bdrc3t1LaiWtygbJ4jD6') }

  context 'by id' do
    context 'when the user exists' do
      use_vcr_cassette 'user exists with id'

      it 'returns a user with the correct attributes' do
        user = board.users.find(100)

        user.id.should == 100
        user.email.should == 'candidate@recruitmilitary.com'
        user.first_name.should == 'Michael'
        user.last_name.should == 'Jordan'
      end
    end

    context 'when the user does not exist' do
      use_vcr_cassette 'user id does not exist'

      it 'raises a not found exception' do
        expect {
          board.users.find(42)
        }.to raise_error(Board::Request::NotFound)
      end
    end
  end

  context 'by email' do
    context 'when the user exists' do
      use_vcr_cassette 'user exists with email'

      it 'returns a user with the correct attributes' do
        user = board.users.find(:email => 'candidate@recruitmilitary.com')

        user.email.should == 'candidate@recruitmilitary.com'
      end
    end

    context 'when the user does not exist' do
      use_vcr_cassette 'user email does not exist'

      it 'raises a not found exception' do
        expect {
          board.users.find(:email => 'michael@jordan.com')
        }.to raise_error(Board::Request::NotFound)
      end
    end
  end

  context 'by email_md5' do
    context 'when the user exists' do
      use_vcr_cassette 'user exists with email md5'

      it 'returns a user with the correct attributes' do
        user = board.users.find(:email_md5 => '7618e7a4937b37640c24149bdf21cf27')

        user.email.should == 'candidate@recruitmilitary.com'
      end
    end

    context 'when the user does not exist' do
      use_vcr_cassette 'user email md5 does not exist'

      it 'raises a not found exception' do
        expect {
          board.users.find(:email_md5 => '93e8d736de5088cb392465e024b69eef')
        }.to raise_error(Board::Request::NotFound)
      end
    end
  end
end

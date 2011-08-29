require 'spec_helper'

describe 'User Find' do

  context 'by id' do
    context 'when the user exists' do
      use_vcr_cassette 'user exists with id'

      it 'returns a user with the correct attributes' do
        user = board.users.find(1)

        user.id.should == 1
        user.email.should == 'staff@recruitmilitary.com'
        user.first_name.should == 'Staff'
        user.last_name.should == 'McStafforson'
      end
    end

    context 'when the user does not exist' do
      use_vcr_cassette 'user id does not exist'

      it 'raises a not found exception' do
        expect {
          board.users.find(42)
        }.to raise_error(Board::Client::NotFound)
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
        }.to raise_error(Board::Client::NotFound)
      end
    end
  end

  context 'by email_md5' do
    context 'when the user exists' do
      use_vcr_cassette 'user exists with email md5'

      it 'returns a user with the correct attributes' do
        user = board.users.find(:email_md5 => '3e67fa7c8045d085e66a51deee26cbc4')

        user.email.should == 'staff@recruitmilitary.com'
      end
    end

    context 'when the user does not exist' do
      use_vcr_cassette 'user email md5 does not exist'

      it 'raises a not found exception' do
        expect {
          board.users.find(:email_md5 => '93e8d736de5088cb392465e024b69eef')
        }.to raise_error(Board::Client::NotFound)
      end
    end
  end
end

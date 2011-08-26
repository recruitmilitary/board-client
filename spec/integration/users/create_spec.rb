require 'spec_helper'

describe 'User Create' do

  Board::Client.default_url = 'http://localhost:3000/api/v1'

  let(:board) { Board::Client.new('Bdrc3t1LaiWtygbJ4jD6') }

  def create_user(attributes = {})
    attributes = attributes.merge(
      :email           => "steve@apple.com",
      :first_name      => "Steve",
      :last_name       => "Jobs",
      :primary_role_id => 1,
      :password              => "password",
      :password_confirmation => "password")

    board.users.create(attributes)
  end

  context 'when no user with the email exists' do
    use_vcr_cassette "user does not exist"

    it 'creates the user' do
      user = create_user

      user.email.should == "steve@apple.com"
      user.first_name.should == "Steve"
      user.last_name.should == "Jobs"
    end
  end

  context 'when a user with the email exists' do
    use_vcr_cassette "user does exist"

    it 'raises an error' do
      begin
        create_user
      rescue Board::Request::Error => e
      end

      e.response.body.should =~ /is already taken/
    end
  end

  context 'when missing required attributes' do
    use_vcr_cassette "user missing attributes"

    it 'raises an error' do
      expect {
        create_user(:email => nil)
      }.to raise_error
    end
  end


end

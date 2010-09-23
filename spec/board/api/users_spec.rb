require 'spec_helper'

describe Board::API::Users do

  let(:client) { Board::Client.new('VALID_KEY') }

  before do
    stub_request(:get, "https://board.recruitmilitary.com/api/v1/users?email=jerry@seinfeld.com&user_credentials=VALID_KEY").
      to_return(:body => %q{[{"id":1,"last_name":"Seinfeld","first_name":"Jerry","email":"jerry@seinfeld.com"}]})
  end

  describe "#find" do

    it 'should return an array of hashes' do
      response = client.users.find(:email => 'jerry@seinfeld.com')

      response.should == [{ "id" => 1,
                            "last_name" => "Seinfeld",
                            "first_name" => "Jerry",
                            "email" => "jerry@seinfeld.com"}]
    end

  end

end

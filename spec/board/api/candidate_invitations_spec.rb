require 'spec_helper'

describe Board::API::CandidateInvitations do

  let(:client) { Board::Client.new('VALID_KEY') }

  before do
    stub_request(:post, "https://board.recruitmilitary.com/api/v1/candidate_invitations").
      with(:body => {
             "first_name" => "Michael",
             "email" => "michael.jordan@nike.com",
             "last_name" => "Jordan",
             "user_credentials" => "VALID_KEY"}).
      to_return(:body => %q{{"created_at":"2010-09-21T17:51:23Z","accepted_at":null,"updated_at":"2010-09-21T17:51:23Z","secret_id":"5991a3d7c0fdfe0b6fa659ff8b5de18d","id":3,"last_name":"bar","organization_id":null,"first_name":"foo","email":"foo@bar.com"}})
  end

  describe "#create" do

    context 'when successful' do
      it 'should return a hash representing the saved invitation' do
        response = client.candidate_invitations.create(:first_name => "Michael",
                                                       :last_name  => "Jordan",
                                                       :email      => "michael.jordan@nike.com")
        response.should == {
          "id"              => 3,
          "first_name"      => "foo",
          "last_name"       => "bar",
          "email"           => "foo@bar.com",
          "secret_id"       => "5991a3d7c0fdfe0b6fa659ff8b5de18d",
          "organization_id" => nil,
          "accepted_at"     => nil,
          "created_at"      => "2010-09-21T17:51:23Z",
          "updated_at"      => "2010-09-21T17:51:23Z",
        }
      end
    end

  end

end

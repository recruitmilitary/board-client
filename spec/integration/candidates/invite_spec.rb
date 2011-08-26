require 'spec_helper'

describe 'Candidate Invite' do

  let(:board) { Board::Client.new('Bdrc3t1LaiWtygbJ4jD6') }

  def create_invitation(attributes = {})
    attributes = {
      :email      => "makers@mark.com",
      :first_name => "Maker's",
      :last_name  => "Mark"
    }.merge(attributes)

    board.candidates.invite(attributes)
  end

  context 'when the email is not already registered' do
    context 'and the invitation is valid' do
      use_vcr_cassette 'candidate invite when valid'

      it 'returns an invitation with the correct attributes' do
        invitation = create_invitation

        invitation.email.should == "makers@mark.com"
      end
    end

    context 'and the invitation is not valid' do
      use_vcr_cassette 'candidate invite when invalid'

      it 'raises an error' do
        expect {
          create_invitation(:email => nil)
        }.to raise_error
      end
    end
  end

  # TODO: should this be considered when the invitation is not valid?
  context 'when the email belongs to an existing user' do
    use_vcr_cassette 'candidate invite email exists'

    it 'raises a conflict error' do
      expect {
        create_invitation(:email => "candidate@recruitmilitary.com")
      }.to raise_error(Board::Client::Conflict)
    end
  end

end

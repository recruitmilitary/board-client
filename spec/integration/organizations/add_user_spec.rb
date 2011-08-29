require 'spec_helper'

describe 'Organization Add User' do

  let(:board) { Board::Client.new('Bdrc3t1LaiWtygbJ4jD6') }

  context 'when the user and organization exist' do
    use_vcr_cassette "organization add user"

    it 'responds with an empty success' do
      response = board.user_organizations.create(:user_id => 1, :organization_id => 3)
      response.should be_true
    end
  end

  context 'when the user does not exist' do
    use_vcr_cassette "organization add user - user does not exist"

    it 'raises a not found error' do
      expect {
        board.user_organizations.create(:user_id => 100_000, :organization_id => 1)
      }.to raise_error(Board::Client::NotFound)
    end
  end

  context 'when the organization does not exist' do
    use_vcr_cassette "organization add user - organization does not exist"

    it 'raises a not found error' do
      expect {
        board.user_organizations.create(:user_id => 1, :organization_id => 100_000)
      }.to raise_error(Board::Client::NotFound)
    end
  end

end

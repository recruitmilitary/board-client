require 'spec_helper'

describe 'List User Organizations' do

  let(:board) { Board::Client.new('Bdrc3t1LaiWtygbJ4jD6') }

  context 'with a valid user id' do
    use_vcr_cassette "list user organizations with valid id"

    it 'returns a list of organizations that the user belong to' do
      organizations = board.user_organizations.list(:user_id => 1)

      organizations.size.should == 2
      organization = organizations.first

      organization.name.should == "Employer Organization"
    end
  end

  context 'without a user id' do
    it 'raises an error' do
      expect {
        board.user_organizations.list(:foo => :bar)
      }.to raise_error(ArgumentError)
    end
  end

  context 'with an invalid user id' do
    use_vcr_cassette "list user organizations with invalid id"

    it 'raises an error' do
      expect {
        board.user_organizations.list(:user_id => 1_000_000)
      }.to raise_error(Board::Client::NotFound)
    end
  end

end

require 'spec_helper'

describe 'Organization Find' do

  context 'by id' do
    context 'when the organization exists' do
      use_vcr_cassette 'organization exists with id'

      it 'returns an organization with the correct attributes' do
        organization = board.organizations.find(1)

        organization.id.should == 1
        organization.name.should == "RecruitMilitary"
      end
    end

    context 'when the organization does not exist' do
      use_vcr_cassette 'organization id does not exist'

      it 'raises a not found error' do
        expect {
          board.organizations.find(100_000)
        }.to raise_error(Board::Client::NotFound)
      end
    end
  end

  context 'by name' do
    context 'when the organization exists' do
      use_vcr_cassette 'organization exists with email'

      it 'returns an organization with the correct attributes' do
        organization = board.organizations.find(:name => "RecruitMilitary")

        organization.name.should == "RecruitMilitary"
      end
    end

    context 'when the organization does not exist' do
      use_vcr_cassette 'organization name does not exist'

      it 'raises a not found error' do
        expect {
          board.organizations.find(:name => "Blah Blah")
        }.to raise_error(Board::Client::NotFound)
      end
    end
  end

end

require 'spec_helper'

describe 'Organization Create' do

  let(:board) { Board::Client.new('Bdrc3t1LaiWtygbJ4jD6') }

  def create_organization(attributes = {})
    attributes = {
      :name        => "Nike",
      :description => "<h1>Nike Shoes</h1>",
      :website     => "http://nike.com",
    }.merge(attributes)

    board.organizations.create(attributes)
  end

  context 'when valid' do
    use_vcr_cassette "organization create is valid"

    it 'creates the organization' do
      organization = create_organization

      organization.id.should_not be_blank
      organization.name.should == "Nike"
      organization.description.should == "<h1>Nike Shoes</h1>"
      organization.website.should == "http://nike.com"
    end
  end

  context 'when invalid' do
    use_vcr_cassette "organization create is invalid"

    it 'raises an error' do
      expect {
        create_organization(:name => nil)
      }.to raise_error
    end
  end

end

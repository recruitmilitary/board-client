require 'spec_helper'

module RequestTracking

  class Request < Struct.new(:path, :params, :method); end

  def request(path, params, method)
    requests << Request.new(path, params, method)
  end

  def requests
    @requests ||= []
  end

end

describe Board::Client do

  let(:client) {
    client = Board::Client.new('VALID_KEY')
    client.extend(RequestTracking)
    client
  }

  def last_request
    @last_request ||= client.requests.last
  end

  describe "when creating" do
    context 'and missing an API key' do
      it 'should raise an error' do
        expect { Board::Client.new }.to raise_error
      end
    end

    context "with an API key" do
      it 'should not raise an error' do
        Board::Client.new('API_KEY')
      end
    end
  end

  describe '#candidate_searches' do
    it 'performs the correct request' do
      client.candidate_searches(:keywords => 'ruby', :location => 'Cincinnati')

      last_request.path.should == '/candidate_searches'
      last_request.method.should == :get
      last_request.params.should == {
        :keywords => "ruby",
        :location => "Cincinnati",
      }
    end
  end

  describe '#find_user' do
    it 'performs the correct request' do
      client.find_user(:email => 'bob@rm.com')

      last_request.path.should == '/users'
      last_request.method.should == :get
      last_request.params.should == { :email => 'bob@rm.com' }
    end
  end

  describe '#mark_user_invalid' do
    it 'performs the correct request' do
      client.mark_user_invalid(:email => 'bob@rm.com')

      last_request.path.should == '/users/invalid'
      last_request.method.should == :get
      last_request.params.should == { :email => 'bob@rm.com' }
    end
  end

  describe '#unsubscribe' do
    it 'performs the correct request' do
      client.unsubscribe(:email => 'bob@rm.com')

      last_request.path.should == '/users/unsubscribe'
      last_request.method.should == :get
      last_request.params.should == { :email => 'bob@rm.com' }
    end
  end

  describe '#create_candidate_invitation' do
    it 'performs the correct request' do
      client.create_candidate_invitation(:email => 'bob@rm.com')

      last_request.path.should == '/candidate_invitations'
      last_request.method.should == :post
      last_request.params.should == { :email => 'bob@rm.com' }
    end
  end

  describe '#candidates' do
    it 'performs the correct request' do
      client.find_candidate(42)

      last_request.path.should == '/candidates/42'
      last_request.method.should == :get
      last_request.params.should == {}
    end
  end

end

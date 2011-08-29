require 'spec_helper'

describe Board::Client do

  let(:client) { Board::Client.new('VALID_KEY') }

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

  describe "when processing responses" do
    {
      400 => Board::Client::BadRequest,
      401 => Board::Client::Unauthorized,
      403 => Board::Client::Forbidden,
      404 => Board::Client::NotFound,
      406 => Board::Client::NotAcceptable,
      409 => Board::Client::Conflict,
      422 => Board::Client::UnprocessableEntity,
      500 => Board::Client::InternalServerError,
      501 => Board::Client::NotImplemented,
      502 => Board::Client::BadGateway,
      503 => Board::Client::ServiceUnavailable,
    }.each do |code, exception|
      context "when HTTP status code is #{code}" do
        before do
          stub_request(:get, 'http://localhost:3000/api/v1/users/42').
            to_return(:status => code)
        end

        it "raises #{exception.name} error" do
          expect {
            client.users.find(42)
          }.to raise_error(exception)
        end
      end
    end
  end

end

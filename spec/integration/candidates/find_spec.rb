require 'spec_helper'

describe 'Candidate Find' do

  let(:board) { Board::Client.new('Bdrc3t1LaiWtygbJ4jD6') }

  context 'by id' do
    context 'when the candidate exists' do
      use_vcr_cassette 'candidate exists with id'

      it 'returns a user with the correct attributes' do
        candidate = board.candidates.find(100)

        candidate.id.should == 100
        candidate.email.should == 'candidate@recruitmilitary.com'
      end
    end

    context 'when the candidate does not exist' do
      use_vcr_cassette 'candidate id does not exist'

      it 'raises a not found exception' do
        expect {
          board.candidates.find(42)
        }.to raise_error(Board::Request::NotFound)
      end
    end
  end

end

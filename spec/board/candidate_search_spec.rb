require 'spec_helper'

describe Board::CandidateSearch do

  let(:search) { Board::CandidateSearch.new(client, :keywords => 'ruby') }
  let(:client) { Board::Client.new('VALID_KEY') }

  before do
    stub_request(:get, "https://board.recruitmilitary.com/api/v1/candidate_searches").
      with(:body => "user_credentials=VALID_KEY&keywords=ruby").
      to_return(:body => %q{{"results":[{"email":"candidate@recruitmilitary.com","zip_code":null,"last_activity_at":"2010-11-24T14:13:26Z","phone":null,"state":"OH","last_name":"Smith","first_name":"Rodolfo","resume_url":null,"location":"Hagenesside, OH","city":"Hagenesside"},{"email":"benton@effertz.info","zip_code":null,"last_activity_at":"2010-11-16T14:13:26Z","phone":null,"state":"OH","last_name":"Bins","first_name":"Alfred","resume_url":null,"location":"East Elizabeth, OH","city":"East Elizabeth"},{"email":"melba@armstrong.us","zip_code":null,"last_activity_at":"2010-11-22T14:13:27Z","phone":null,"state":"OH","last_name":"Pouros","first_name":"Warren","resume_url":null,"location":"Margemouth, OH","city":"Margemouth"},{"email":"yvette@lynch.name","zip_code":null,"last_activity_at":"2010-11-25T14:13:27Z","phone":null,"state":"OH","last_name":"Denesik","first_name":"Isai","resume_url":null,"location":"Lake Othaton, OH","city":"Lake Othaton"},{"email":"hipolito.mosciski@schoenbrown.uk","zip_code":null,"last_activity_at":"2010-11-25T14:13:28Z","phone":null,"state":"OH","last_name":"Paucek","first_name":"Cristina","resume_url":"https://localhost/resumes/1/resume.pdf","location":"East Aiden, OH","city":"East Aiden"},{"email":"lydia@cassin.name","zip_code":null,"last_activity_at":"2010-11-13T14:13:29Z","phone":null,"state":"OH","last_name":"Johnson","first_name":"Marianna","resume_url":null,"location":"Bartonhaven, OH","city":"Bartonhaven"},{"email":"gabe@price.ca","zip_code":null,"last_activity_at":"2010-11-16T14:13:29Z","phone":null,"state":"OH","last_name":"Wolf","first_name":"Idell","resume_url":"https://localhost/resumes/2/resume.pdf","location":"South Angelinestad, OH","city":"South Angelinestad"},{"email":"monserrat_douglas@zemlakbrekke.biz","zip_code":null,"last_activity_at":"2010-11-16T14:13:30Z","phone":null,"state":"OH","last_name":"Shanahan","first_name":"Zelda","resume_url":null,"location":"Mosesstad, OH","city":"Mosesstad"},{"email":"vada.hauck@gaylordbosco.co.uk","zip_code":null,"last_activity_at":"2010-11-12T14:13:30Z","phone":null,"state":"OH","last_name":"Bergstrom","first_name":"Anabelle","resume_url":null,"location":"Cliffordhaven, OH","city":"Cliffordhaven"},{"email":"maeve@abernathywaelchi.info","zip_code":null,"last_activity_at":"2010-12-01T14:13:31Z","phone":null,"state":"OH","last_name":"Gibson","first_name":"Rubie","resume_url":null,"location":"New Tre, OH","city":"New Tre"}],"page":1,"total":15}})
    stub_request(:get, "https://board.recruitmilitary.com/api/v1/candidate_searches").
      with(:body => "user_credentials=VALID_KEY&page=2&keywords=ruby").
      to_return(:body => %q{{"results":[{"email":"candidate@recruitmilitary.com","zip_code":null,"last_activity_at":"2010-11-24T14:13:26Z","phone":null,"state":"OH","last_name":"Smith","first_name":"Rodolfo","resume_url":null,"location":"Hagenesside, OH","city":"Hagenesside"},{"email":"benton@effertz.info","zip_code":null,"last_activity_at":"2010-11-16T14:13:26Z","phone":null,"state":"OH","last_name":"Bins","first_name":"Alfred","resume_url":null,"location":"East Elizabeth, OH","city":"East Elizabeth"},{"email":"melba@armstrong.us","zip_code":null,"last_activity_at":"2010-11-22T14:13:27Z","phone":null,"state":"OH","last_name":"Pouros","first_name":"Warren","resume_url":null,"location":"Margemouth, OH","city":"Margemouth"},{"email":"yvette@lynch.name","zip_code":null,"last_activity_at":"2010-11-25T14:13:27Z","phone":null,"state":"OH","last_name":"Denesik","first_name":"Isai","resume_url":null,"location":"Lake Othaton, OH","city":"Lake Othaton"},{"email":"hipolito.mosciski@schoenbrown.uk","zip_code":null,"last_activity_at":"2010-11-25T14:13:28Z","phone":null,"state":"OH","last_name":"Paucek","first_name":"Cristina","resume_url":"https://localhost/resumes/1/resume.pdf","location":"East Aiden, OH","city":"East Aiden"}],"page":2,"total":15}})
    stub_request(:get, "https://board.recruitmilitary.com/api/v1/candidate_searches").
      with(:body => "user_credentials=VALID_KEY&per_page=501").
      to_return(:body   => %q{[["per_page", "must be less than or equal to 500"]]},
                :status => 422)
  end

  describe "searching", "when valid" do
    it 'returns the correct number of results' do
      search.results.size.should == 10
    end

    it 'iterates through all results' do
      results = []
      search.each_result do |result|
        results << result
      end
      results.size.should == 15
    end
  end

  describe "searching", "when invalid" do
    let(:search) { Board::CandidateSearch.new(client, :per_page => '501') }

    it 'returns a collection of errors' do
      search.valid?

      search.errors.should == [["per_page", "must be less than or equal to 500"]]
    end
  end

end

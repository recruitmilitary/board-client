require 'spec_helper'

describe Board::API::CandidateSearches do

  let(:client) { Board::Client.new('VALID_KEY') }
  let(:search) { client.candidate_search(:keywords => "ruby") }

  before do
    stub_request(:get, "https://board.recruitmilitary.com/api/v1/candidate_searches").
      with(:query => {
             'user_credentials' => 'VALID_KEY',
             'keywords'         => 'ruby',
           }).
      to_return(:body => %q{{"results":[{"email":"candidate@recruitmilitary.com","zip_code":null,"last_activity_at":"2010-11-24T14:13:26Z","phone":null,"state":"OH","last_name":"Smith","first_name":"Rodolfo","resume_url":null,"location":"Hagenesside, OH","city":"Hagenesside"},{"email":"benton@effertz.info","zip_code":null,"last_activity_at":"2010-11-16T14:13:26Z","phone":null,"state":"OH","last_name":"Bins","first_name":"Alfred","resume_url":null,"location":"East Elizabeth, OH","city":"East Elizabeth"},{"email":"melba@armstrong.us","zip_code":null,"last_activity_at":"2010-11-22T14:13:27Z","phone":null,"state":"OH","last_name":"Pouros","first_name":"Warren","resume_url":null,"location":"Margemouth, OH","city":"Margemouth"},{"email":"yvette@lynch.name","zip_code":null,"last_activity_at":"2010-11-25T14:13:27Z","phone":null,"state":"OH","last_name":"Denesik","first_name":"Isai","resume_url":null,"location":"Lake Othaton, OH","city":"Lake Othaton"},{"email":"hipolito.mosciski@schoenbrown.uk","zip_code":null,"last_activity_at":"2010-11-25T14:13:28Z","phone":null,"state":"OH","last_name":"Paucek","first_name":"Cristina","resume_url":"https://localhost/resumes/1/resume.pdf","location":"East Aiden, OH","city":"East Aiden"},{"email":"lydia@cassin.name","zip_code":null,"last_activity_at":"2010-11-13T14:13:29Z","phone":null,"state":"OH","last_name":"Johnson","first_name":"Marianna","resume_url":null,"location":"Bartonhaven, OH","city":"Bartonhaven"},{"email":"gabe@price.ca","zip_code":null,"last_activity_at":"2010-11-16T14:13:29Z","phone":null,"state":"OH","last_name":"Wolf","first_name":"Idell","resume_url":"https://localhost/resumes/2/resume.pdf","location":"South Angelinestad, OH","city":"South Angelinestad"},{"email":"monserrat_douglas@zemlakbrekke.biz","zip_code":null,"last_activity_at":"2010-11-16T14:13:30Z","phone":null,"state":"OH","last_name":"Shanahan","first_name":"Zelda","resume_url":null,"location":"Mosesstad, OH","city":"Mosesstad"},{"email":"vada.hauck@gaylordbosco.co.uk","zip_code":null,"last_activity_at":"2010-11-12T14:13:30Z","phone":null,"state":"OH","last_name":"Bergstrom","first_name":"Anabelle","resume_url":null,"location":"Cliffordhaven, OH","city":"Cliffordhaven"},{"email":"maeve@abernathywaelchi.info","zip_code":null,"last_activity_at":"2010-12-01T14:13:31Z","phone":null,"state":"OH","last_name":"Gibson","first_name":"Rubie","resume_url":null,"location":"New Tre, OH","city":"New Tre"}],"current_page":1,"total":101}})
  end

  describe "searching" do

    it 'returns the number of search results' do
      search.total.should == 101
    end

    it 'returns the current page' do
      search.current_page.should == 1
    end

  end

end

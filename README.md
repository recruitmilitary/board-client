# Board::Client

## TODO

* Organization / User update add organization to user or add user to organization

## Usage

    board = Board::Client.new('YOUR_API_KEY_HERE')

### Search

All methods named search return search object that support a few elements of convenience.  Each search API returns a similar format and supports similar options.

    search.results # current page of results
    search.each_result { |result| p result } # iterate through all pages of results
    search.total # total number of results
    search.page # current page number

### User Search

    # should this mimic candidate search with keywords?
    board.users.search(:email => "foo@bar.com")

### User Create

    user = board.users.create(:email      => "foo@bar.com",
                              :first_name => "Bob",
                              :last_name  => "Smith")

    user.email      # => "foo@bar.com"
    user.first_name # => "Bob"
    user.last_name  # => "Smith"
    user.id         # => 42

### Organization Search

    board.organizations.search(:name => "Nike")

### Organization Create

    organization = board.organizations.create(:name => "Nike"
                                              :url  => "http://nike.com")

    organization.name # => "Nike"
    organization.url  # => "http://nike.com"
    organization.id   # => 9

### Candidate Search

    board.candidates.search(:keywords => "ruby",
                            :distance => 50,
                            :location => "Cincinnati, OH")

### Candidate Invitations

    invitation = client.candidates.invitation(:first_name => "Michael",
                                              :last_name  => "Jordan",
                                              :email      => "michael.jordan@nike.com")

    invitation.url        # => "https://board.recruitmilitary.com/invitations/abcdefghijklmnopqrstuvwxyz0123456789"
    invitation.first_name # => "Michael"
    invitation.last_name  # => "Jordan"
    invitation.email      # => "michael.jordan@nike.com"

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2011 Michael Guterl. See LICENSE for details

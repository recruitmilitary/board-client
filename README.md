# board-client

    client = Board::Client.new('YOUR_API_KEY_HERE')

## candidate searches

    search = client.candidate_search(:keywords => "ruby",
                                     :distance => 50,
                                     :location => "Cincinnati, OH")

iterate through current page of results

    search.results.each do |result|

    end

iterate through all pages and yield result

    search.each_result do |result|

    end

## invitations

    invitation = client.create_invitation(:first_name => "Michael",
                                          :last_name  => "Jordan",
                                          :email      => "michael.jordan@nike.com")

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2010 Michael Guterl. See LICENSE for details.

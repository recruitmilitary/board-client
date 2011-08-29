module IntegrationHelpers

  def board
    @board ||= Board::Client.new('Bdrc3t1LaiWtygbJ4jD6')
  end

end

RSpec.configure do |config|
  def config.escaped_path(*parts)
    Regexp.compile(parts.join('[\\\/]'))
  end

  config.include IntegrationHelpers, :type => :integration, :example_group => {
    :file_path => config.escaped_path(%w[spec integration])
  }
end

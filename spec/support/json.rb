require 'json'

module JsonParser
  # Parses text into a JSON object. Default is response.body.
  #
  # Can be used to quickly assert json in any specs. EX:
  #
  #     get :index
  #     json['badge']['firstname'].should == 'ryan'
  #
  # Returns hash for json.
  #
  # TODO: turn into lazy container with method access.
  def json(text = response.body)
    JSON.parse(text)
  end
end

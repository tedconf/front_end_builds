require 'rails_helper'

describe "Front end builds API", type: :request do
  let(:front_end_app) { FactoryGirl.create :front_end_builds_app, name: "dummy" }

  it "creates a new build and then uses it" do
    stub_request(
      :get,
      "www.ted.com/builds/1"
    ).to_return(
      body: 'your app!'
    )

    post "/dummy",
      api_key: front_end_app.api_key,
      branch: "master",
      sha: "a1b2c3",
      job: "jenkins-build-1",
      endpoint: "http://www.ted.com/builds/1"

    expect(response).to be_success

    # Index loads
    get "/dummy"
    expect(response).to be_success
    expect(response.body).to match(/your app!$/)

    # Deep routes load
    get "/dummy/posts/1"
    expect(response).to be_success
    expect(response.body).to match(/your app!$/)
  end
end

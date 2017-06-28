require 'rails_helper'

describe "Front end builds API", type: :request do
  let!(:front_end_app) { FactoryGirl.create :front_end_builds_app, name: "dummy" }
  let(:endpoint) { "http://www.ted.com/builds/1" }

  before(:each) do
    stub_request(:get, endpoint)
      .to_return(body: 'your app!')

    FactoryGirl.create(:front_end_builds_pubkey, :fixture_pubkey)
  end

  it "creates a new build and then uses it" do
    post "/dummy",
      params: {
        branch: "master",
        sha: "a1b2c3",
        job: "jenkins-build-1",
        endpoint: endpoint,
        signature: create_signature("dummy-#{endpoint}")
      }

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

  it "should be able to create a build from a generic endpoint" do
    post "/front_end_builds/builds",
      params: {
        app_name: 'dummy',
        branch: "master",
        sha: "a1b2c3",
        job: "jenkins-build-1",
        endpoint: endpoint,
        signature: create_signature("dummy-#{endpoint}")
      }

    expect(response).to be_success
    expect(front_end_app.builds.length).to eq(1)
    expect(front_end_app.builds.first.html).to eq('your app!')
  end
end

describe 'It should not intercept API requests', type: :request do
  let(:front_end_app) { create :front_end_builds_app, name: "dummy" }

  let!(:build) do
    create(:front_end_builds_build, :live,
      app: front_end_app,
      fetched: true,
      active: true
    )
  end

  it "should get the build" do
    get "/dummy"
    expect(response).to be_success
  end

  it "should allow api requests to come through" do
    get "/items/1.json"
    expect(response).to be_success
    expect(JSON.parse(response.body)['it']).to eq('worked')
  end
end

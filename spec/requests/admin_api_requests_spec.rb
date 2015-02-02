describe 'The API for the admin section should work', type: :request do
  it 'should load the admin' do
    get '/frontend-config'
    expect(response).to be_success
  end

  it "should respond to the admin's API requests" do
    get '/frontend-config/api/host_apps/current.json'
    expect(response).to be_success
    expect(json['host_app']['name']).to eq('Dummy')
  end
end

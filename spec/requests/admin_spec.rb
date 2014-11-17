describe 'Admin interface', type: :request do
  it "should say admin" do
    get "/front-end-builds"
    expect(response).to be_success
  end
end

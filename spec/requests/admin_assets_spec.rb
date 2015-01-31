describe 'I should be able to access the admin assets', type: :request do
  let(:admin_javascript_file_disk) do
    Dir["public/front_end_builds/assets/admin-*.js"].first
  end

  let(:admin_javascript_url) do
    admin_javascript_file_disk.gsub(/^public/, '')
  end

  let(:admin_javascript_content) do
    File.read(admin_javascript_file_disk)
  end

  it 'should return the js file' do
    get admin_javascript_url
    expect(response).to be_success
    expect(response.body).to eq(admin_javascript_content)
  end
end

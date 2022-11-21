require 'rails_helper'

RSpec.describe 'Application', type: :request do
  let(:endpoint) { FactoryBot.create(:endpoint) }

  it 'returns the expected output' do
    expect(endpoint.id).to eq(1)
    get '/api/v1/hello'

    expect(response).to have_http_status(200)
    expect(response.body).to eq(endpoint.body)
  end

  it 'returns 404 for the requested path' do
    get '/not/valid'

    expect(response).to have_http_status(404)
    expect(JSON.parse(response.body)['errors'][0]['detail'])
      .to eq("Requested page `/not/valid` does not exist")
  end
end

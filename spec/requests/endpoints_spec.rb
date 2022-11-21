require 'rails_helper'

RSpec.describe 'Endpoints API', type: :request do
    let(:valid_endpoint) do
        {
            data: {
                type: 'endpoints',
                attributes: {
                    path: '/api/v1/hello',
                    verb: 'GET',
                    response: {
                        body: '"{ "message": "Hello world" }"',
                        code: 200,
                        headers: {
                            "Content-Type": "application/json"
                        }
                    }
                }
            }
        }
    end
    describe 'GET /endpoints' do
        let(:endpoint) { FactoryBot.create(:endpoint) }
        it 'returns all endpoints' do
            expect(endpoint.id).to eq(1)
      
            get '/endpoints'
            expect(response).to have_http_status(200)
            expect(JSON.parse(response.body)['data'].size).to eq(1)
            expect(JSON.parse(response.body)['data'][0]['attributes']['path']).to eq('/api/v1/hello')
            expect(JSON.parse(response.body)['data'][0]['attributes']['verb']).to eq('GET')
        end
    end

    describe 'GET /endpoints/:id' do
        let(:endpoint) { FactoryBot.create(:endpoint) }
        it 'returns endpoint with corresponding id' do
            expect(endpoint.id).to eq(1)
            get '/endpoints/1'
            expect(response).to have_http_status(200)
            expect(JSON.parse(response.body)['data']['attributes']['path']).to eq(endpoint.path)
        end

        it 'returns 404 when id does not exist' do
            get '/endpoints/1'
            expect(response).to have_http_status(404)
            expect(JSON.parse(response.body)['errors'][0]['detail']).to eq("Requested Endpoint with ID #{endpoint.id} does not exist")
        end
    end

    describe 'POST /endpoint' do
        let(:invalid_endpoint) do
            valid_endpoint[:data][:type] = 'invalid'
            valid_endpoint[:data][:attributes][:verb] = nil
            valid_endpoint
        end

        it 'creates a new endpoint with valid parameters' do
            expect do
              post '/endpoints', params: valid_endpoint
            end.to change { Endpoint.count }.from(0).to(1)
      
            expect(response).to have_http_status(201)
            expect(JSON.parse(response.body)['data']['attributes']['path']).to eq('/api/v1/hello')
            expect(JSON.parse(response.body)['data']['id']).to eq(1)
        end

        it 'creates a new endpoint with valid parameters' do
            post '/endpoints', params: invalid_endpoint
            expect(response).to have_http_status(422)
        end
    end

    describe 'PATCH /endpoint' do
        let(:endpoint) { FactoryBot.create(:endpoint) }
        let(:updated_params) do
            valid_endpoint[:data][:attributes][:path] = '/updated/path'
            valid_endpoint
        end
        let(:invalid_endpoint) do
            valid_endpoint[:data][:type] = 'invalid'
            valid_endpoint[:data][:attributes][:verb] = nil
            valid_endpoint
        end

        it 'update endpoint with a new path' do
            expect(endpoint.id).to eq(1)
            expect(endpoint.path).to eq('/api/v1/hello')

            patch '/endpoints/1', params: updated_params

            expect(response).to have_http_status(200)
            expect(JSON.parse(response.body)['data']['attributes']['path']).to eq('/updated/path')
            expect(JSON.parse(response.body)['data']['id']).to eq(1)
        end

        it 'update endpoint with a new path' do
            expect(endpoint.id).to eq(1)
            expect(endpoint.path).to eq('/api/v1/hello')

            patch '/endpoints/1', params: invalid_endpoint

            expect(response).to have_http_status(422)
        end

        it 'update endpoint that does not exists' do

            patch '/endpoints/1', params: invalid_endpoint

            expect(response).to have_http_status(404)
        end
    end

    describe 'DELETE /endpoint/:id' do
        let(:endpoint) { FactoryBot.create(:endpoint) }
        let(:valid_id) { endpoint.id }
        let(:invalid_id) { 2 }
        it 'deletes an endpoint when valid id passed' do
            expect(endpoint.id).to eq(1)
      
            delete "/endpoints/#{valid_id}"
            expect(response).to have_http_status(204)
        end
      
        it 'returns an error when invalid id passed' do
            delete "/endpoints/#{invalid_id}"
            expect(response).to have_http_status(404)
            expect(JSON.parse(response.body)['errors'][0]['detail'])
            .to eq("Requested Endpoint with ID #{invalid_id} does not exist")
        end
    end
end
FactoryBot.define do
    factory :endpoint do
      sequence(:id) { |n| }
      path { '/api/v1/hello' }
      code { 200 }
      body { '"{ "message": "Hello world" }"' }
      verb { 'get' }
      headers { { "Content-Type": 'application/json' } }
    end
end
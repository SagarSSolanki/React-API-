require 'swagger_helper'

RSpec.describe 'discounts', type: :request do

  path '/discounts' do

    get('Calculate Discount') do
      tags 'Discounts'
      consumes 'application/json'
      parameter name: 'items', in: :query, type: :string, description: 'Item List', required: true
      security [Bearer: []]
      response(200, 'fetched user info successfully') do
        run_test!
      end
    end
  end
end

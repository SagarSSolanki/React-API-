require 'swagger_helper'

RSpec.describe 'item_total', type: :request do

  path '/item_total' do

    get('List Item Totals') do
        tags 'Products'
        consumes 'application/json'
        parameter name: 'str', in: :query, type: :string, description: 'Item Code List', required: true
        security [Bearer: []]
        response(200, 'fetched user info successfully') do
          run_test!
        end
    end
  end
end

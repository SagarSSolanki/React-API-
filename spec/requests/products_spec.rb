require 'swagger_helper'

RSpec.describe 'products', type: :request do

  path '/products' do

    get('List Products') do
        tags 'Products'
        consumes 'application/json'
        security [Bearer: []]
        response(200, 'fetched user info successfully') do
          run_test!
        end
    end
  end

  path '/products/{id}' do
    put('Update Product Price') do
        tags 'Product'
        consumes 'multipart/form-data'
        security [Bearer: []]
        parameter name: 'id', in: :path, type: :integer, description: 'product id', required: true
        parameter name: 'price', in: :query, type: :integer, description: 'product price', required: true

        response(200, 'successful') do
        run_test!
        end
    end
  end
end

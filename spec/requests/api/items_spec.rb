require 'swagger_helper'

RSpec.describe 'api/items', type: :request do
  path '/todos/{todo_id}/items' do
    get 'Retrieves all items of a todo list' do
      produces 'application/json'
      parameter name: :todo_id, in: :path, type: :integer

      response '200', 'items found' do
        run_test!
      end
    end

    post 'Creates an item for a todo list' do
      consumes 'application/json'
      parameter name: :todo_id, in: :path, type: :integer
      parameter name: :item, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          done: { type: :boolean },
        },
        required: ['name', 'done'],
      }

      response '201', 'item created' do
        run_test!
      end
    end
  end

  path '/todos/{todo_id}/items/{id}' do
    put 'Updates an item of a todo list' do
      consumes 'application/json'
      parameter name: :todo_id, in: :path, type: :integer
      parameter name: :id, in: :path, type: :integer
      parameter name: :item, in: :body, schema: {
        type: :object,
        properties: {
          done: { type: :boolean },
        },
      }

      response '204', 'item updated' do
        run_test!
      end
    end

    delete 'Deletes an item of a todo list' do
      parameter name: :todo_id, in: :path, type: :integer
      parameter name: :id, in: :path, type: :integer

      response '204', 'item deleted' do
        run_test!
      end
    end
  end
end

require 'swagger_helper'

RSpec.describe 'api/items', type: :request do
  let(:todo_id) { 123 }
  let(:todo) { Todo.create!(id: 123, title: 'Example Todo', created_by: 'Test User') }
  let(:item) { { name: 'Test Item', done: false } }

  path '/todos/{todo_id}/items' do
    get 'Retrieves all items of a todo list' do
      produces 'application/json'
      parameter name: :todo_id, in: :path, type: :integer

      response '200', 'items found' do
        let(:todo_id) { todo.id }
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
        let(:todo_id) { todo.id }
        let(:item) { { name: 'Test Item', done: false } }
        run_test!
      end
    end
  end

  path '/todos/{todo_id}/items/{id}' do
    parameter name: :id, in: :path, type: :integer

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
        let(:todo_id) { todo.id }
        let(:id) { Item.create!(name: 'Test Item', done: false, todo_id: todo.id).id } #Ensure item exists
        run_test!
      end
    end

    delete 'Deletes an item of a todo list' do
      parameter name: :todo_id, in: :path, type: :integer
      parameter name: :id, in: :path, type: :integer

      response '204', 'item deleted' do
        let(:todo_id) { todo.id }
        let(:id) { Item.create!(name: 'Test Item', done: false, todo_id: todo.id).id } #Ensure item exists
        run_test!
      end
    end
  end
end

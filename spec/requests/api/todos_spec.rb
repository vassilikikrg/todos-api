require 'swagger_helper'

RSpec.describe 'api/todos', type: :request do
  path '/todos' do
    get 'Retrieves all todo lists' do
      produces 'application/json'
      response '200', 'todo lists found' do
        run_test!
      end
    end

    post 'Creates a todo list' do
      consumes 'application/json'
      parameter name: :todo, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          created_by: { type: :integer },
        },
        required: ['title', 'created_by'],
      }

      response '201', 'todo list created' do
        run_test!
      end
    end
  end

  path '/todos/{id}' do
    put 'Updates a todo list' do
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: :todo, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
        },
      }

      response '204', 'todo list updated' do
        run_test!
      end
    end

    delete 'Deletes a todo list' do
      parameter name: :id, in: :path, type: :integer

      response '204', 'todo list deleted' do
        run_test!
      end
    end
  end
end


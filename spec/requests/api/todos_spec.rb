require 'swagger_helper'

RSpec.describe 'api/todos', type: :request do
  path '/todos' do
    # GET request for retrieving all todo lists
    get 'Retrieves all todo lists' do
      produces 'application/json'
      response '200', 'todo lists found' do
        run_test!
      end
    end

    # POST request for creating a todo list
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
        let(:todo) { { title: 'Test Todo', created_by: 1 } } 
        run_test!
      end
    end
  end

  path '/todos/{id}' do
    parameter name: :id, in: :path, type: :integer

    # PUT request for updating a todo list
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
        let(:id) { Todo.create!(title: 'Test Todo', created_by: 1).id } 
        let(:todo) { { title: 'Updated Todo' } }
        run_test!
      end
    end

    # DELETE request for deleting a todo list
    delete 'Deletes a todo list' do
      parameter name: :id, in: :path, type: :integer

      response '204', 'todo list deleted' do
        let(:id) { Todo.create!(title: 'Test Todo', created_by: 1).id }
        run_test!
      end
    end
  end
end
